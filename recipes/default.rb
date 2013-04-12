#
# Cookbook Name:: liquibase
# Recipe:: default
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

include_recipe "java"

src_filepath = "#{Chef::Config[:file_cache_path]}/#{::File.basename(node[:liquibase][:url])}"

remote_file node[:liquibase][:url] do
  source node[:liquibase][:url]
  checksum node[:liquibase][:checksum]
  path src_filepath
  backup false
  notifies :run, "bash[extract_liquibase]"
end

bash "extract_liquibase" do
  cwd ::File.dirname(src_filepath)
  code <<-EOH
    mkdir -p #{node[:liquibase][:install_path]}
    tar zxf #{src_filepath} -C #{node[:liquibase][:install_path]}
  EOH

  not_if { File.exists?("#{node[:liquibase][:install_path]}/liquibase.jar") }
end
