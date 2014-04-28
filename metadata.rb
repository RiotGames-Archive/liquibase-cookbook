name             "liquibase"
maintainer       "Riot Games"
maintainer_email "bluepojo@gmail.com"
license          "Apache 2.0"
description      "Installs and configures Liquibase"
version          "1.0.0"

%w{ centos redhat fedora }.each do |os|
  supports os
end

depends "java"
