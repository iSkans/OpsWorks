Chef::Log.info("Deploy Proxy Configuration to Nginx.")
node[:deploy].each do |application, deploy|
	if deploy[:application_type] != 'nodejs'
		next
	end	
	execute "proxy2ensite #{application}" do
		command "/usr/sbin/proxy2ensite #{application}"
		notifies :reload, "service[nginx]"
	end
end

