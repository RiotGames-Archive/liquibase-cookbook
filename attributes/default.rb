#
# Cookbook Name:: liquibase
# Attributes:: default
#
# Author:: Jamie Winsor (<jamie@vialstudios.com>)
#
# Copyright 2012, Riot Games
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

default[:liquibase][:version]      = "3.1.1"
default[:liquibase][:url]          = "http://softlayer-dal.dl.sourceforge.net/project/liquibase/Liquibase%20Core/liquibase-#{node[:liquibase][:version]}-bin.tar.gz"
default[:liquibase][:checksum]     = "91c237126ad37703e8e04bb49235044c"
default[:liquibase][:install_path] = "/opt/liquibase-#{node[:liquibase][:version]}"
