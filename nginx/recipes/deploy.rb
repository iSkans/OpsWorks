include_recipe 'deploy'
include_recipe "nginx::service"

node[:deploy].each do |application, deploy|
  if deploy[:application_type] != 'nodejs'
    Chef::Log.debug("Skipping deploy::nodejs-proxy for application #{application} as it is not a node.js app")
    next
  end

  nginx_proxy_app application do
    application deploy
    cookbook "nginx"
  end
end
