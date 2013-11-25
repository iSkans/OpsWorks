include_recipe 'deploy'
include_recipe "nginx::service"

Chef::Log.info("Deploy Proxy Configuration to Nginx.")
node[:deploy].each do |application, deploy|
	if deploy[:application_type] != 'nodejs'
		next
	end	
	Chef::Log.info("Deploy Proxy Configuration to Nginx.")
	execute "proxy2ensite #{application} #{deploy[:deploy_to]}" do
		command "/usr/sbin/proxy2ensite #{application} #{deploy[:deploy_to]} #{deploy[:domains].join(',')}"
		notifies :reload, "service[nginx]"
	end
end

