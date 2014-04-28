# liquibase cookbook

# Requirements

* Chef 10
* Centos / Redhat / Fedora

# License and Author

Author:: Jamie Winsor (<reset@riotgames.com>)  
Author:: Jesse Howarth (<jhowarth@riotgames.com>)

Maintainer:: Josiah Kiehl (<jkiehl@riotgames.com>)

Copyright 2012-2013, Riot Games

See LICENSE for license details

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
adapter                    | Database adapter                                                                                                    | Symbol  | :mysql
contexts                   | Contexts to run the migrations in                                                                                   | String  | live
cwd                        | The directory to run the migrations from                                                                            | String  | 
change_log_properties      | A hash where the keys are property names and the values are property values for substitution into the change log(s) | Hash    | {}
