include_recipe 'deploy'
include_recipe "nginx::service"

Chef::Log.info("Deploy Proxy Configuration to Nginx.")
node[:deploy].each do |application, deploy|
	if deploy[:application_type] != 'nodejs'
		next
	end	
	Chef::Log.info("Deploy To : #{deploy[:deploy_to]}")
	Chef::Log.info("Application : #{application}")
	Chef::Log.info("Application name : #{deploy[:application_name]}")
	Chef::Log.info("Application name2 : #{deploy[:name]}")
	Chef::Log.info("Application domains : #{deploy[:domains]}")
	Chef::Log.info("Application domains : #{deploy}")
	Chef::Log.info("Deploy Proxy Configuration to Nginx.")
	execute "proxy2ensite #{application} #{deploy[:deploy_to]}" do
		command "/usr/sbin/proxy2ensite #{application} #{deploy[:deploy_to]} #{deploy[:application_name]}"
		notifies :reload, "service[nginx]"
	end
end

