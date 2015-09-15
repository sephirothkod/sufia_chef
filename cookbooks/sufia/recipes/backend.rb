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
bash "create headless install settings for mysql" do
  code <<-EOH 
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password rootpass'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password rootpass'
sudo debconf-set-selections <<< 'oracle-java8-installer shared/accepted-oracle-license-v1-1 select true'
   EOH
end


execute "install SQLite3" do
  command "sudo apt-get -q -y install sqlite3"
  ignore_failure false
end



#execute "install mysql" do
#  command "sudo apt-get -q -y install mysql-server-5.5 libmysqlclient-dev"
#  ignore_failure false
#end
#
#bash "create databases" do
#  code <<-EOH
#    mysql -u root -prootpass -e "create database uvic_sufia_development"
#    mysql -u root -prootpass -e "create database uvic_sufia_test"
#    mysql -u root -prootpass -e "create database uvic_sufia_production"
#    EOH
#end
#
#bash "create user" do
#  code <<-EOH
#    mysql -u root -prootpass -e "create user fedoraAdmin@localhost identified by 'fedoraAdmin';"
#    EOH
#end
#
#bash "grant permissions" do
#  code <<-EOH
#    mysql -u root -prootpass -e "grant all on uvic_sufia_development.* to fedoraAdmin@localhost;"
#    mysql -u root -prootpass -e "grant all on uvic_sufia_test.* to fedoraAdmin@localhost;"
#    mysql -u root -prootpass -e "grant all on uvic_sufia_production.* to fedoraAdmin@localhost;"
#    mysql -u root -prootpass -e "flush privileges;"
#    EOH
#end

execute "common properties" do
  command "sudo apt-get -q -y install software-properties-common"
  ignore_failure false
end

execute "python properties" do
  command "sudo apt-get -q -y install python-software-properties"
  ignore_failure false
end

execute "add ruby source" do
  command "sudo apt-add-repository -y ppa:brightbox/ruby-ng"
  ignore_failure false
end

execute "add java source" do
  command "sudo apt-add-repository -y ppa:webupd8team/java"
  ignore_failure false
end

execute "update" do
  command "sudo apt-get update"
  ignore_failure false
end

execute "install java" do
  command "sudo apt-get -q -y install oracle-java8-installer"
  ignore_failure false
end

execute "set java defaults" do
  command "sudo apt-get -q -y install oracle-java8-set-default"
  ignore_failure false
end

execute "get ruby2.2" do
  command "sudo apt-get -q -y install ruby2.2"
  ignore_failure false
end

execute "get ruby2.2 dev" do
  command "sudo apt-get -q -y install ruby2.2-dev"
  ignore_failure false
end

execute "get ruby switcher" do
  command "sudo apt-get -q -y install ruby-switch"
  ignore_failure false
end

execute "switch to ruby 2.2" do
  command "sudo ruby-switch --set ruby2.2"
  ignore_failure false
end

execute "nokogiri prep" do
  command "sudo apt-get -q -y install libxslt-dev libxml2-dev zlib1g-dev libsqlite3-dev"
  ignore_failure false
end

execute "get rails" do
  command "sudo gem install rails -v4.2"
  ignore_failure false
end

execute "create new app" do
  command "rails new #{node['sufia']['directory']}"
  ignore_failure false
end

execute "change ownership" do
  command "chown -R #{node['user']['name']}:#{node['user']['name']} #{node['sufia']['directory']}"
  ignore_failure false
end

execute "remove Gemfile" do
  command "rm #{node['sufia']['directory']}/Gemfile"
  ignore_failure false
end

template "replace Gemfile" do
  source "Gemfile"
  path "#{node['sufia']['directory']}/Gemfile"
  mode "0666"
end

file "#{node['sufia']['directory']}/Gemfile.lock" do
  content " "
  owner node['user']['name']
  group node['user']['name']
  mode "0666"
end

file "#{node['sufia']['directory']}/log/development.log" do
  content " "
  owner node['user']['name']
  group node['user']['name']
  mode "0666"
  action :create_if_missing
end 

# Generate templated database.yml
template "template database.yml" do
  source "database.yml.erb"
  path "#{node['sufia']['directory']}/config/database.yml"
  mode "0666"
end

# Generate templated fedora.yml
#template "template fedora.yml" do
#  source "fedora.yml.erb"
#  path "#{node['sufia']['directory']}/config/fedora.yml"
#  mode "0666"
#end

# Generate templated solr.yml
template "template solr.yml" do
  source "solr.yml.erb"
  path "#{node['sufia']['directory']}/config/solr.yml"
  mode "0666"
end

execute "install bundler" do
  command "sudo gem2.2 install bundler -i ~/sufia"
  ignore_failure false
end

