#
# Cookbook Name:: liquibase
# Provider:: migrate
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

require 'mixlib/shellout'
require 'shellwords'

def load_current_resource
  new_resource.connection[:port] ||= 3306
  @current_resource = Chef::Resource::LiquibaseMigrate.new(new_resource.name)
end

action :run do
  if should_migrate?
    Chef::Log.info "[liquibase] Database needs migrating - running migrations."
    perform_migrate
    new_resource.updated_by_last_action(true)
  end
end

action :force do
  Chef::Log.info "[liquibase] Forcing migrations to run."
  perform_migrate
  new_resource.updated_by_last_action(true)
end

private

  def perform_migrate
    cmd = liquibase_cmd("update")
    cmd.run_command
    unless cmd.status.exitstatus == 0
      Chef::Log.fatal cmd.stderr
      Chef::Log.fatal cmd.stdout
      raise
    end

    true
  end

  def liquibase_jar
    if new_resource.jar 
      Shellwords.escape(new_resource.jar)
    else
      "#{Shellwords.escape(node[:liquibase][:install_path])}/liquibase.jar"
    end
  end

  def change_log_properties
    new_resource.change_log_properties.map { |k, v| "-D#{k}=#{v}" }
  end

  def should_migrate?
    Chef::Log.info "[liquibase] Checking to see if database needs migrating."
    cmd = liquibase_cmd("status")
    cmd.run_command
    cmd.stdout.match(/is up to date/).nil?
  end

  def liquibase_cmd(*args)
    options = default_options + args + change_log_properties
    Mixlib::ShellOut.new(options, :env => {'LC_ALL' => 'en_US.UTF-8'} ,:cwd => new_resource.cwd)
  end
  
  def default_options
    options = [
      "/usr/bin/java",
      "-jar",
      liquibase_jar,
      "--driver=#{Shellwords.escape(new_resource.driver)}",
      "--classpath=#{Shellwords.escape(new_resource.classpath)}",
      "--changeLogFile=#{Shellwords.escape(new_resource.change_log_file)}",
      "--url=#{Shellwords.escape(new_resource.connection_url)}",
      "--username=#{Shellwords.escape(new_resource.connection[:username])}",
      "--password=#{Shellwords.escape(new_resource.connection[:password])}"
    ]

    if new_resource.contexts
      contexts = if new_resource.contexts.is_a?(Array)
        new_resource.contexts.split(",")
      else
        new_resource.contexts
      end

      options << "--contexts=#{Shellwords.escape(contexts)}"
    end

    options
  end
