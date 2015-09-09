#
# Cookbook Name:: sufia
# Recipe:: backend
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

execute "get rails" do
  command "sudo gem install rails -v4.2"
  ignore_failure false
end

execute "create new app" do
  command "rails sufia"
  ignore_failure false
end

execute "remove Gemfile" do
  command "rm #{node['sufia']['directory']}/Gemfile"
  ignore_failure false
end

template "replace Gemfile" do
  source "Gemfile"
  path "#{node['sufia']['directory']}/Gemfile"
  mode "0644"
end

# Generate templated database.yml
template "template database.yml" do
  source "database.yml.erb"
  path "#{node['sufia']['directory']}/config/database.yml"
  mode "0644"
end

# Generate templated fedora.yml
template "template fedora.yml" do
  source "fedora.yml.erb"
  path "#{node['sufia']['directory']}/config/fedora.yml"
  mode "0644"
end

execute "enter sufia" do
  command "cd #{node['sufia']['directory']}"
  ignore_failure false
end

execute "bundle install" do
  command "sudo bundle install"
  ignore_failure false
end

execute "install sufia" do
  command "rails generate sufia:install -f"
  ignore_failure false
end

execute "install sufia-roles" do
  command "rails generate roles"
  ignore_failure false
end

execute "database stuff" do
  command "rake db:migrate"
  ignore_failure false
end





