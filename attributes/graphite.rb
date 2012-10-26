#
# Cookbook Name:: graphite
# Attributes:: default
# Author:: Julian C. Dunn <jdunn@secondmarket.com>
#
# Copyright 2012, SecondMarket Labs, LLC
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

default[:graphite][:version] = "0.9.10"

default[:graphite][:carbon][:uri] = "http://launchpadlibrarian.net/82112362/carbon-#{node[:graphite][:version]}.tar.gz"
default[:graphite][:carbon][:checksum] = "b3d42e3b93c09"

default[:graphite][:whisper][:uri] = "http://launchpadlibrarian.net/82112367/whisper-#{node[:graphite][:version]}.tar.gz"
default[:graphite][:whisper][:checksum] = "66c05eafe8d86"

default[:graphite][:graphite_web][:uri] = "http://launchpadlibrarian.net/82112308/graphite-web-#{node[:graphite][:version]}.tar.gz"
default[:graphite][:graphite_web][:checksum] = "cc78bab7fb26b"

default[:graphite][:carbon][:line_receiver_interface] =   "0.0.0.0"
default[:graphite][:carbon][:pickle_receiver_interface] = "0.0.0.0"
default[:graphite][:carbon][:cache_query_interface] =     "0.0.0.0"
default[:graphite][:carbon][:user] = "carbon"
default[:graphite][:carbon][:group] = "carbon"

default[:graphite][:web][:password] = "graphite"
default[:graphite][:web][:virtualhostname] = "localhost"
