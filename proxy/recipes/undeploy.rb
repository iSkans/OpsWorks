include_recipe 'deploy'
include_recipe "nginx::service"

node[:deploy].each do |application, deploy|
	if deploy[:application_type] != 'nodejs'
		next
	end	
	Chef::Log.info("Undeploy Nginx Proxy Configuration for #{application}.")
	execute "proxy2dissite #{application}" do
		command "/usr/sbin/proxy2dissite #{application}"
		notifies :reload, "service[nginx]"
	end
end




