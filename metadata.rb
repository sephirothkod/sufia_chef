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

name             'sufia-hydra'
maintainer       'B Justice'
maintainer_email 'bjustice@uvic.ca'
license          "Apache 2.0 <http://www.apache.org/licenses/LICENSE-2.0.html>"
description      'Installs/Configures Sufia'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '6.3.0'

# Use specific versions of recipes because upstream versions have bugs

depends 	 'java'
depends		 'ark::default'
depends          'git'
depends		 'fits'
depends          'mysql', '= 5.5.3'
