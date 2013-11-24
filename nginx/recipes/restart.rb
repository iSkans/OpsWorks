#
# Cookbook Name:: deploy
# Recipe:: web-restart

include_recipe 'deploy'

node[:deploy].each do |application, deploy|
  if deploy[:application_type] != 'nodejs'
    Chef::Log.debug("Skipping deploy::nodejs-proxy for application #{application} as it is not a node.js app")
    next
  end

  service 'nginx' do
    supports :status => true, :restart => true, :reload => true
    action :restart
  end
end
