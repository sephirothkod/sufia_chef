#
# Cookbook Name:: hydra-jetty
# Recipe:: default
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

#remote_file "#{node['sufia']['directory']}/hydra-jetty.zip" do
#  source "#{node['hydra-jetty']['web-dir']node['hydra-jetty']['web-dir']}.zip"
#  checksum node['hydra-jetty']['sha256']
#  owner node['user']['name']
#  group node['user']['name']
#  mode 0644
#end

execute "clean" do
  command "rake jetty:clean"
  ignore_failure false
end

execute "config" do
  command "rake sufia:jetty:config"
  ignore_failure false
end

execute "start" do
  command "rake jetty:start"
  ignore_failure false
end
