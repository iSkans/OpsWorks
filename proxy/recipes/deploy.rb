include_recipe 'deploy'
include_recipe "nginx::service"

Chef::Log.info("Deploy Default Website")
execute "nxensite default" do
	command "/usr/sbin/nxensite default"
	notifies :reload, "service[nginx]"
end

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

