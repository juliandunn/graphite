#
# Cookbook Name:: graphite
# Recipe:: default
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
# limitations unde

include_recipe "python"

package "python-twisted-core" do
  action :install
end

python_pip "carbon" do
  action :install
  version node[:graphite][:version]
end

template "/etc/init.d/carbon-cache" do
  owner "root"
  group "root"
  mode 00755
  source "carbon-cache.init.erb"
end

user node[:graphite][:carbon][:user] do
  action :create
end

service "carbon-cache" do
  supports [ :start, :stop, :restart ]
  action :enable
end

template "/opt/graphite/conf/carbon.conf" do
  owner "root"
  group "root"
  mode 00644
  variables( :line_receiver_interface => node[:graphite][:carbon][:line_receiver_interface],
             :pickle_receiver_interface => node[:graphite][:carbon][:pickle_receiver_interface],
             :cache_query_interface => node[:graphite][:carbon][:cache_query_interface] )
  notifies :restart, "service[carbon-cache]"
end

template "/opt/graphite/conf/storage-schemas.conf" do
  owner "root"
  group "root"
  mode 00644
end

%w{/opt/graphite/storage/whisper /opt/graphite/storage/log/carbon-cache}.each do |d|
  directory d do
    owner node[:graphite][:carbon][:user]
    group node[:graphite][:carbon][:group]
    action :create
    mode 00755
  end
end

service "carbon-cache" do
  action :start
end
