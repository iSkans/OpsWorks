include_recipe 'deploy'
include_recipe "nginx::service"

node[:deploy].each do |application, deploy|
	if deploy[:application_type] != 'nodejs'
		next
	end	
	Chef::Log.info("Deploy Nginx Proxy Configuration for #{application}.")
	execute "proxy2ensite #{application} #{deploy[:deploy_to]}" do
		command "/usr/sbin/proxy2ensite #{application} #{deploy[:deploy_to]} #{deploy[:domains].join(',')}"
		notifies :reload, "service[nginx]"
	end
end

