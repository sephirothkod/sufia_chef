#
# Cookbook Name:: sufia
# Recipe:: final
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

execute "#{node['sufia']['directory']}/app/models/user.rb" do
  command "cp /#{node['user']['name']}/cookbooks/sufia/files/user.rb #{node['sufia']['directory']}/app/models/"
end

file "#{node['sufia']['directory']}/app/models/user.rb" do
  mode '0755'
  owner node['user']['name']
  group node['user']['name']
  action :touch
end

execute "#{node['sufia']['directory']}/user_setup.rb" do
  command "cp /#{node['user']['name']}/cookbooks/sufia/files/user_setup.rb #{node['sufia']['directory']}/"
end

file "#{node['sufia']['directory']}/user_setup.rb" do
  mode '0755'
  owner node['user']['name']
  group node['user']['name']
  action :touch
end

#execute "setup user file" do
#  command "rails runner #{node['sufia']['directory']}/user_setup.rb #{node['sufia']['directory']}"
#  ignore_failure false
#end
