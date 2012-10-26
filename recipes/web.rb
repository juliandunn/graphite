#
# Cookbook Name:: graphite
# Recipe:: web
#
# Copyright 2012, SecondMarket Labs, LLC.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
include_recipe "apache"
include_recipe "apache::mod_wsgi"

%w{pycairo Django django-tagging python-ldap python-twisted-core python-memcached python-sqlite2}.each do |p|
  package p do
    action :install
  end
end

python_pip "graphite-web" do
  action :install
  version node[:graphite][:version]
end

cookbook_file "/opt/graphite/conf/graphite.wsgi" do
  owner "root"
  group "root"
  mode 00755
  action :create
end

apache_virtualhost "http #{node[:graphite][:web][:virtualhostname]}" do
  cookbook "graphite"
  servername node[:graphite][:web][:virtualhostname]
  serveralias node[:fqdn]
  template "graphite-vhost.conf.erb"
end

directory "/opt/graphite/storage" do
  owner node[:apache][:user]
  group node[:apache][:group]
end

directory "/opt/graphite/storage/log/webapp" do
  owner node[:apache][:user]
  group node[:apache][:group]
end

cookbook_file "/opt/graphite/bin/set_admin_passwd.py" do
  owner "root"
  group "root"
  mode 00755
end

cookbook_file "/opt/graphite/storage/graphite.db" do
  action :create_if_missing
  owner node[:apache][:user]
  group node[:apache][:group]
  mode 00644
  notifies :run, "execute[set-admin-password]"
end

execute "set-admin-password" do
  command "/opt/graphite/bin/set_admin_passwd.py root #{node[:graphite][:web][:password]}"
  action :nothing
end
