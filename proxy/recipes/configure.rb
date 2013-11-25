Chef::Log.info("Add Proxy Configuration to Nginx.")
template "#{node[:nginx][:dir]}/conf.d/proxy.conf" do
	source "proxy.conf.erb"
	owner "root"
	group "root"
	mode 0644
	not_if do 
      ::File.exists?("#{node[:nginx][:dir]}/conf.d/proxy.conf")
    end
end

include_recipe "nginx::service"

service "nginx" do
	action [ :reload ]
end
