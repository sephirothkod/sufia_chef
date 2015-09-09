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

directory "#{node['user']['dir']}/redis" do
  owner node['user']['name']
  group node['user']['name']
  mode '0755'
  action :create
end

remote_file "#{node['user']['dir']}/redis/redis.tar.gz" do
  source "#{node['redis']['web-dir']}#{node['redis']['version']}.tar.gz"
  mode "0644"
  checksum node['redis']['sha256']
  action :create_if_missing
end

execute "unpack redis" do
  command "tar xzf #{node['user']['dir']}/redis/redis.tar.gz -C #{node['user']['dir']}/redis"
  ignore_failure false
end



