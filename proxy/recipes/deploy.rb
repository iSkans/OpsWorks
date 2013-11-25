include_recipe 'deploy'
include_recipe "nginx::service"

Chef::Log.info("Deploy Proxy Configuration to Nginx.")

application = params[:application]
application_name = params[:name]

execute "proxy2ensite #{application_name}" do
	command "/usr/sbin/proxy2ensite #{application_name}"
	notifies :reload, "service[nginx]"
end

