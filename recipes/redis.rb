#
# Cookbook Name:: sufia
# Recipe:: redis
#
# Copyright 2015, University of Victoria Library, sephirothkod
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

execute "enter sufia dir" do
  command "cd #{node['sufia']['directory']}"
  ignore_failure false
end

remote_file "#{node['sufia']['directory']}/redis.tar.gz" do
  source "#{node['redia']['web-dir']}redis-#{node['redia']['version']}.tar.gz"
  mode "0644"
  checksum node['redis']['sha256']
  action :create_if_missing
end

execute "unpack redis" do
  command "tar xzf redis-3.0.3.tar.gz"
  ignore_failure false
end

execute "enter redis dir" do
  command "cd redis-3.0.3"
  ignore_failure false
end

execute "make redis" do
  command "make"
  ignore_failure false
end

execute "start redis server" do
  command "gnome-terminal -x sh -c \"redis-server; bash\""
  ignore_failure false
end


