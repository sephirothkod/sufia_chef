#
# Cookbook Name:: sufia
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

# Java Backend
include_recipe 'git'
include_recipe 'ark::default'
include_recipe 'imagemagick'
include_recipe 'database::mysql'
include_recipe 'sufia::backend'
include_recipe 'hydra-jetty'
include_recipe 'sufia::fits'
include_recipe 'sufia::redis'
include_recipe 'sufia::final'
