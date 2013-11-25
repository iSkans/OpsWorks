include_recipe 'deploy'
include_recipe "nginx::service"

Chef::Log.info("Deploy Proxy Configuration to Nginx.")
node[:deploy].each do |application, deploy|
	if deploy[:application_type] != 'nodejs'
    	next
	end	
	
	bash "site_available" do
		user "root"
		cwd "#{deploy[:deploy_to]}/current"    
		code <<-EOH
IP=`sed -n 's/[\t ]*"proxy":[\t ]*"\([^"]*\).*/\1/p' package.json`
PORT=`sed -n 's/[\t ]*"port":[\t ]*"\([^"]*\).*/\1/p' package.json`
echo "server {
	listen 80;
	server_name $DOMAINS;
	location / {
		proxy_pass http://$IP:$PORT/;
	}
}" > titi
EOH
		environment({"DOMAINS" => "api.mangakas.fr"})
	end
end
 