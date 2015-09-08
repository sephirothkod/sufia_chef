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

#default user
default['user']['name'] = 'hydra'
default['user']['pass'] = 'hydra'

# Java defaults
default['java']['jdk_version'] = '8'
default['java']['install_flavor'] = 'oracle'
default['java']['oracle']['accept_oracle_download_terms'] = true

# Required defaults for chef-solo for MySQL
default['mysql']['server_root_password'] = 'rootpass'
default['mysql']['server_repl_password'] = 'replpass'
default['mysql']['server_debian_password'] = 'debpass'
default['mysql']['bind_address'] = 'localhost'

default['sufia']['directory'] = "/home/#{node['user']['name']}/sufia"

# Sufia-specific libraries / packages
default['sufia']['libraries'] = [
  # core libraries
  'php-soap',
  'php5-curl',
  'php5-xsl',

  # image-handling libraries
  'php5-imagick',
  'imagemagick',
  'graphicsmagick-imagemagick-compat',

  # htop
  'htop',

  # OCR
  'poppler-utils',

  # media-handling libraries
  'ffmpeg2theora',
  'lame',
  'libavcodec-extra-53',
  'libimage-exiftool-perl',
  'libogg0',
  'libtheora0',
  'libvorbis0a',

  'bibutils',
]

# FITS specific
default['fits']['version'] = "0.6.2"
default['fits']['sha256'] = '76566872F960115404C98B1BB1F9151A5805FC7384CB254C08152D11415C1354'
default['fits']['installpath'] = "/usr/share/fits"
default['fits']['shellpath'] = "/usr/share/fits/fits.sh"
default['fits']['techmd_dsid'] = "TECHMD_FITS"

# Imagemagick specific
default['imagemagick']['convert'] = '/usr/bin/convert'
default['imagemagick']['toolkit'] = 'imagemagick' # NB: defaults to GD2
default['imagemagick']['gm'] = 0 # NB: 1 = enable GraphicsMagick support
default['imagemagick']['quality'] = 100

# Tesseract specific
default['tesseract']['sha256'] = '26cd39cb3f2a6f6f1bf4050d1cc0aae35edee49eb49a92df3cb7f9487caa013d'
default['tesseract']['version'] = '3.02.02'
default['tesseract']['installpath'] = '/usr/share/tesseract'
default['tesseract']['binarypath'] = '/usr/local/bin/tesseract'
default['tesseract_engdata']['sha256'] = 'c110029560e7f6d41cb852ca23b66899daa4456d9afeeae9d062204bd271bdf8'
default['tesseract_engdata']['version'] = '3.02'
default['tesseract_engdata']['installpath'] = '/usr/local/share/tessdata'

# FFmpeg specific
default['ffmpeg']['sha256'] = '3385f7e0d2aa1f57049ecf8a2f6f88f302141b442d895c89b7565b16b8835969'
default['ffmpeg']['version'] = '1.1.4'
default['ffmpeg']['installpath'] = '/usr/local/ffmpeg-1.1.4'
default['ffmpeg']['binarypath'] = '/usr/local/bin/ffmpeg'

# Audio collection specific
default['audio']['lamearg'] = "/usr/bin/lame"

# ingest derivatives field
#default['ingestderivatives']['arg'] = "array('pdf' => 'pdf', 'image' => 'image', 'ocr' => 'ocr')"
