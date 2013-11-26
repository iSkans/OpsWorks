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
	
	Chef::Log.info("Restart NodeJS Application #{application}.")
	Chef::Log.info("Restart Current PAth #{application}.")
	execute "Restart NodeJS Application #{application}." do
		cwd deploy[:current_path]
		command "sleep #{deploy[:sleep_before_restart]} && #{deploy[:restart_command]}"
		action :run
		only_if do 
			File.exists?(deploy[:current_path])
		end
	end
end

