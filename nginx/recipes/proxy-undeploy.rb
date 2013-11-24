#
# Cookbook Name:: deploy
# Recipe:: web-undeploy

include_recipe 'deploy'
include_recipe 'nginx::service'

node[:deploy].each do |application, deploy|
  if deploy[:application_type] != 'nodejs'
    Chef::Log.debug("Skipping undeploy::nodejs-proxy for application #{application} as it is not a node.js app")
    next
  end
  
  link "#{node[:nginx][:dir]}/sites-enabled/#{application}" do
    action :delete
    only_if do 
      ::File.exists?("#{node[:nginx][:dir]}/sites-enabled/#{application}")
    end
    notifies :restart, "service[nginx]"
  end
  
  directory "#{deploy[:deploy_to]}" do
    recursive true
    action :delete
    only_if do 
      ::File.exists?("#{deploy[:deploy_to]}")
    end
  end
end


