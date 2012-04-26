name             "liquibase"
maintainer       "Riot Games"
maintainer_email "jamie@vialstudios.com"
license          "Apache 2.0"
description      "Installs and configures Liquibase"
version          "0.0.1"

%w{ centos redhat fedora }.each do |os|
  supports os
end

depends "java"
