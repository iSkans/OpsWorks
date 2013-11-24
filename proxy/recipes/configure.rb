template "#{node[:nginx][:dir]}/conf.d/proxy.conf" do
	source "proxy.conf.erb"
	owner "root"
	group "root"
	mode 0644
end

include_recipe "nginx::service"

service "nginx" do
	action [ :enable, :start ]
end
