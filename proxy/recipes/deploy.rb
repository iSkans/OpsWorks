include_recipe 'deploy'
include_recipe "nginx::service"

node[:deploy].each do |application, deploy|
	if deploy[:application_type] != 'nodejs'
    	next
	end	
	
	bash "site_available" do
		user "root"
		cwd "#{deploy[:deploy_to]}/current"    
		code<<-EOF
IP=`sed -n 's/[\t ]*"proxy":[\t ]*"\([^"]*\).*/\1/p' $PATH/package.json`
PORT=`sed -n 's/[\t ]*"port":[\t ]*"\([^"]*\).*/\1/p' $PATH/package.json`
echo "server {
	listen 80;
	server_name $DOMAINS;
	location / {
		proxy_pass http://$IP:$PORT/;
	}
}" > titi
EOF
		environment { 'PATH' => "#{deploy[:deploy_to]}/current", "DOMAINS" => "api.mangakas.fr"}
	end
end
 