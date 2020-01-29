# solr Puppet Module

[![Puppet Forge](http://img.shields.io/puppetforge/v/landcareresearch/solr.svg)](https://forge.puppetlabs.com/landcaresearch/solr)
[![Bitbucket Build Status](http://build.landcareresearch.co.nz/app/rest/builds/buildType%3A%28id%3ALinuxAdmin_PuppetSolr_PuppetSolr%29/statusIcon)](http://build.landcareresearch.co.nz/viewType.html?buildTypeId=LinuxAdmin_PuppetSolr_PuppetSolr&guest=1)

## About

Installs and configures [apache solr](http://lucene.apache.org/solr) and runs the embedded jetty service.

### Solr Versions

* 5.3.x and up   - use solr puppet module 0.5.x
* 5.0.x to 5.2.x - use solr puppet module 0.4.x
* 4.x.x          - use solr puppet module 0.2.2

Also supports systemd.

## Module Description

This module utilizes the params concept so all default parameters are configured through solr::params.

## Setup

### Requirements

The solr puppet module no longer manages java.  However, java is a requirement for installation.

## Usage

### Simple Use Case

Uses the defaults

```puppet
include solr
```

## Installing Cores

Cores can be installed via the defined type solr::core.  Solr requires a restart when a new core is added.
This module doesn't handle restarting solr for adding new cores.

### Installation Example

```puppet
file {'/tmp/schema.xml':
  ensure => file,
  content => inline_template('....'),
}

solr::core{'test':
  schema_src_file => '/tmp/schema.xml',
  require         => File ['/tmp/schema.xml'],
}
```

## Installing Shared Libraries

This defined type allows shared libraries to be installed for use by solr.

### Shared Libraries Example

```puppet
solr::shared_lib{'jts':
  url => 'http://search.maven.org/remotecontent?filepath=com/vividsolutions/jts/1.13/jts-1.13.jar'
}
```

## API

See REFERENCE.md for the API.

## Limitations

Works with debian and redhat based OS's.

## Development

The module is open source and available on bitbucket.  Please fork!
