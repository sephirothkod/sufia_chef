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

template "#{node['sufia']['directory']}/app/models/user.rb" do
  source "user.rb"
  owner node['user']['name']}
  group node['user']['name']}
  made 755
end

template "#{node['sufia']['directory']}/user_setup.rb" do
  source "user_setup.rb"
  owner node['user']['name']}
  group node['user']['name']}
  made 755
end

execute "enter sufia directory" do
  command "cd #{node['sufia']['directory']}"
  ignore_failure false
end

execute "setup user file" do
  command "rails runner user_setup.rb"
  ignore_failure false
end