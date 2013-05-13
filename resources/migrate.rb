#
# Cookbook Name:: liquibase
# Resource:: migrate
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

actions :run, :force

attribute :change_log_file,       :kind_of => String, :name_attribute => true
attribute :jar,                   :kind_of => String
attribute :connection,            :kind_of => Hash, :required => true
attribute :classpath,             :kind_of => String, :required => true
attribute :driver,                :kind_of => String, :default => "com.mysql.jdbc.Driver"
attribute :adapter,               :kind_of => Symbol, :default => :mysql
attribute :contexts,              :kind_of => [String, Array]
attribute :cwd,                   :kind_of => String
attribute :change_log_properties, :kind_of => Hash, :default => Hash.new

def initialize(*args)
  super
  @action = :run
end

def connection_url
  "jdbc:#{adapter}://#{connection[:host]}:#{connection[:port]}/#{connection[:database]}"
end
