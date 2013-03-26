#
# Cookbook Name:: vnstat
# Recipe:: source
#
# Copyright 2013, David Radcliffe
#

bash "install_vnstat" do
  user "root"
  cwd "/tmp"
  code <<-EOH
  wget http://humdi.net/vnstat/vnstat-1.11.tar.gz
  tar -zxf vnstat-1.11.tar.gz
  cd vnstat-1.11
  make
  make install
  EOH
  only_if '[ ! -f "/usr/bin/vnstat" ]'
end

cookbook_file "/etc/init.d/vnstatd" do
  source "init.sh"
  owner "root"
  group "root"
  mode "0755"
end

service "vnstatd" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end
