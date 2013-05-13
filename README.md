# liquibase cookbook

# Requirements

* Chef 10
* Centos / Redhat / Fedora

# License and Author

Author:: Jamie Winsor (<reset@riotgames.com>)
Author:: Jesse Howarth (<jhowarth@riotgames.com>)

Copyright 2012, Riot Games

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

# Resources / Providers

## liquibase_migrate

Migrate a database using a liquibase changelog.

### Actions
Action   | Description                   | Default
-------  |-------------                  |---------
run      | Run the migrations            | Yes
force    | Force run the migrations      |

### Attributes
Attribute                  | Description                                                                                                         |Type     | Default
---------                  |-------------                                                                                                        |-----    |--------
change_log_file            | The liquibase change log file location on disk, relative to the cwd attribute                                       | String  | name
jar                        | The location of the liquibase jar to use                                                                            | String  |
connection                 | Database connection information                                                                                     | Hash    |
classpath                  | The classpath to use when executing the migrations                                                                  | String  |
driver                     | Database driver                                                                                                     | String  | com.mysql.jdbc.Driver
adapter                    | Database adapter                                                                                                    | String  | mysql
contexts                   | Contexts to run the migrations in                                                                                   | String  | live
cwd                        | The directory to run the migrations from                                                                            | String  | 
change_log_properties      | A hash where the keys are property names and the values are property values for substitution into the change log(s) | Hash    | {}
