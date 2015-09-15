#
# Cookbook Name:: sufia
# Recipe:: ffmpeg
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


#install libfaac (this is non-free, but required for MP4 streaming derivatives)
execute "sudo sed -i '/^# deb.*multiverse/ s/^# //' /etc/apt/sources.list && sudo apt-get update && sudo apt-get install libfaac-dev -y --force-yes" do
  environment ({'DEBIAN_FRONTEND' => 'noninteractive'})
  ignore_failure false
end

# install requirements
execute "sudo apt-get install autoconf automake build-essential libass-dev libfreetype6-dev libgpac-dev libsdl1.2-dev libtheora-dev libtool libva-dev libvdpau-dev libvorbis-dev libx11-dev libxext-dev libxfixes-dev pkg-config texi2html zlib1g-dev yasm libfdk-aac-dev libx264-dev libmp3lame-dev unzip x264 libgsm1-dev libopencore-amrnb-dev libopencore-amrwb-dev libopenjpeg-dev libschroedinger-dev libspeex-dev libvpx-dev libxvidcore-dev libdc1394-22-dev -y --force-yes" do
  environment ({'DEBIAN_FRONTEND' => 'noninteractive'})
  ignore_failure false
end

directory "#{node['ffmpeg']['installpath']}" do
  action :create
  owner node['user']['name']
  group node['user']['name']
end

# download FFmpeg source
remote_file "#{node['ffmpeg']['downloadpath']}/ffmpeg-#{node['ffmpeg']['version']}.tar.gz" do
  source "http://www.ffmpeg.org/releases/ffmpeg-#{node['ffmpeg']['version']}.tar.gz"
  checksum node['ffmpeg']['sha256']
end

execute "extract ffmpeg" do
  command "tar xzvf #{node['ffmpeg']['downloadpath']}/ffmpeg-#{node['ffmpeg']['version']}.tar.gz -C #{node['ffmpeg']['downloadpath']}"
end

# run make commands on FFmpeg source to build it
execute "ffmpeg build from source" do
  environment ({'DEBIAN_FRONTEND' => 'noninteractive'})
  command "cd #{node['ffmpeg']['installpath']} && sudo ./configure --enable-gpl --enable-version3 --enable-nonfree --enable-postproc --enable-libopencore-amrnb --enable-libopencore-amrwb --enable-libdc1394 --enable-libfaac --enable-libgsm --enable-libmp3lame --enable-libopenjpeg --enable-libschroedinger --enable-libspeex --enable-libtheora --enable-libvorbis --enable-libvpx --enable-libx264 --enable-libfdk-aac --enable-libxvid && sudo make && sudo make install && sudo ldconfig"
  creates "/usr/local/bin/ffmpeg"
  ignore_failure false
end
