# Solr Puppet Module Changelog

## 2019-10-30 Release 0.7.1

- Used PDK convert to comply with Puppetforge requirements.
- Fixed a ruby linting warning for lib code.
- Updated license in metadata.
- Added Ubuntu 18.04 support.

## 2019-10-29 Release 0.7.0

- Reformatted Changelog to comply with Markdown Linting.
- Updated Readme to comply with Markdown Linting.
- Applied PR by Kris Anderson that fixes an issue with logging on Solr versions above 7.4.0.

## 2018-10-29 Release 0.6.3

- Converted erb to epp for all templates.
- Removed erb files.
- Fixed issue with optional values in epps.
- Fixed issue with syntax error in template.

## 2018-10-01 Release 0.6.2

- Updated metadata's GPL License to comply with [SPDX License](https://spdx.org/licenses/) 3.2
- Changed source in metadata.
 
## 2018-10-01 Release 0.6.1

- [Issue #14](https://bitbucket.org/landcareresearch/puppet-solr/issues/14/is-there-a-way-to-override-ssl-setting-in) - Added SSL Keystore parameters for solr config file.
- Moved solr config file to use epp file format instead of erb.
- Formatted changelog for consistency.
 
## 2018-08-07 Release 0.6.0

- Changed the type for the timeout variable from String to Integer.
- Fixed issue where timeout variable wasn't being used by download program.

## 2018-07-12 Release 0.5.15

- Added data types to parameters.
- Switched to puppet strings documentation style.
- Added reference documentation.
- Removed class parameters from readme.
- Changed formatting in changelog.

## 2018-04-05 Release 0.5.14

- Updated readme with correct installation directory as default.
- Updated readme with note about java requirement.

## 2018-01-22 Release 0.5.13

- Removed installation of oracle's java 8.
- Switched deb based operating systems to use openjdk instead of oracle.
- The change was due to unreliability of the ppa to install oracle java.

## 2017-12-15 Release 0.5.12

- Added a 'schema_name' parameter to customize the 'schema' property in a core's 'core.properties' file. (contributed by Josh Beard)

## 2017-12-06 Release 0.5.11

- A bug was introduced in version 0.5.1 which removed the default solr home parameter. This release fixes that bug.

## 2017-12-05 Release 0.5.10

- Added a parameter to set the loglevel for log4j.

## 2017-12-04 Release 0.5.9

- Added ubuntu 16.04 support
- Fixed an issue with an option 'SOLR_OPTS' delcared in multiple configuration files.

## 2017-11-06 Release 0.5.8

- Fixed a syntax problem for puppet 5.

## 2017-10-03 Release 0.5.7

- Added log4j support (contributed by Maxilian Stinsky)
- Added manage user parameter (contributed by hundredacres)
- Fixed OS Family for Redhat Systems (contributed by hundredacres)

## 2017-08-14 Release 0.5.6

- Renamed parameter 'user' to 'solr_user'
- Added parameter for disabling the installation of java
- Added parameter for configuring ZooKeeper ensemble

## 2017-04-18 Release 0.5.5

- Fixed a minor bug with the solr_heap variable set incorrectly

## 2017-04-05 Release 0.5.4

- Updated required packages for Ubuntu 16.04.
- Updated url to archive.apache.org.
- Updated gemfile for puppet 4 compliance.
- Updated systemd puppet version.

## 2016-11-02 Release 0.5.3

- The schema filename was set to managed-schema for version 5.5.0 and up.
  However, I confirmed this was incorrect for at least version 5.5.3.
  So I changed the conditional to 5.6.0 to use managed-schema and previous
  versions to use schema.xml
- Added a new parameter set to false for managing the solr_install directory.
  By default, its /opt which can easily cause dependency cycles when 
  used with other puppet modules.

## 2016-10-10 Release 0.5.2

## 2016-10-10 Release 0.5.1

- Removed the LSB dependency for redhat systems.
- Updated readme to set a new dependency for solr version supported by this module.

## 2016-08-05 Release 0.5.0

- Updated for Solr6
- Installation uses the production installation script provided by solr.
- Switched to using Java 8.
- Debian based distros use Oracle Java 8 and redhat based use openjdk.
- Java 7 no longer supported.
- Added scripts for testing all supported versions via vagrant.

## 2016-06-28 Release 0.4.0

## 2016-06-28 Release 0.3.7

- Added the flexibility of specifying additional core configuration parameters.
- Added parameters for changing the home and logs dirs.
- Changed default solr version to 5.5.2

## 2016-03-21 Release 0.3.6

- Added support for systemd
- Added new parameter to set the jetty heap size

## 2015-10-19 Release 0.3.2

- [Issue #2](https://jira.landcareresearch.co.nz/browse/DEVOPSPN-359) - added package lsof.

## 2015-09-02 Release 0.3.1

- Fixed a dependency issue causing a fatal installation error.

### Known Issues

- Solr service does not start.  Requires a manual ```service solr start```

## 2015-09-02 Release 0.3.2

- The owner/group of logs directory.

## 2015-09-01 Release 0.3.1

- Added a mechanism to install shared libraries for solr.
- Changed default version of solr from 4.10.3 to 5.3.0.
- Fixed readme typos.

## 2015-09-01 Release 0.3.0

- Added compatability for Solr 5.x
- Is no longer compatible with Solr 4.x
- Removed puppet archive requirement
- Added puppet wget requirement

## 2015-03-17 Release 0.2.3

- Updated Readme to reflect migration to bitbucket and removed author as to promote open source.

## 2015-03-17 Release 0.2.2

- There was an issue with the version that was dependant on the version in the params instead of the specified version.

## 2015-03-17 Release 0.2.1

- Set the java home & java path so that jetty uses the defined java within solr 
  currently using java 7.

## 2015-03-16 Release 0.2.0

- Added a timeout param for downloading the solr package.
- Added a variable to ensure the solr/conf directory is created and managed by puppet.
- Removed parameters from params class and made into variables.  
- Moved variables depending on user settings into init.pp
- Added a defined type for installing cores based on the collections1 example.
- Fixed incorrect puppetforge badge.

### Known Issues

- Does not work with Solr 5.0.x

## 2015-03-04 Release 0.1.1

- Migrated from github to bitbucket
- Changed ownership of puppetforge account
- Created Changelog file.
