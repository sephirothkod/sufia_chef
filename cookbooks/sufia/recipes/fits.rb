#
# Cookbook Name:: sufia
# Recipe:: fits
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
#include_recipe 'ark::default'

directory "#{node['fits']['installpath']}" do
  owner node['user']['name']
  group node['user']['name']
  mode '0755'
  action :create
end

# get FITS from Harvard
remote_file "#{node['fits']['installpath']}/fits.zip" do
  source "http://projects.iq.harvard.edu/files/fits/files/fits-#{node[:fits][:version]}.zip"
  checksum node['fits']['sha256']
  action :create_if_missing
end

# unzip fits
execute "unzip fits" do
  command "unzip #{node['fits']['installpath']}/fits.zip -d #{node['fits']['installpath']}"
  ignore_failure false
end

# make FITS executable
file "#{node['fits']['shellpath']}" do
  mode "0755"
  action :touch
end

execute "add fits to path" do
  command "echo 'export PATH=#{node['fits']['shellpath']}:$PATH' >> ~/.bashrc"
  ignore_failure false
end

