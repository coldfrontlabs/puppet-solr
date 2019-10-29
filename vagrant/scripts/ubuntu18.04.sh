#!/bin/bash

if [ ! -e /home/vagrant/.provision.txt ] ; then
    wget https://apt.puppetlabs.com/puppet5-release-bionic.deb
    dpkg -i puppet5-release-bionic.deb
    apt-get update
    apt-get install --yes puppet-agent
    apt-get install --yes lsb-release
    apt-get install --yes vim
    apt-get install --yes byobu
    apt-get install --yes ruby
    apt-get install --yes software-properties-common
    gem install hiera-eyaml
    /opt/puppetlabs/puppet/bin/gem install hiera-eyaml
    apt-get update
    apt-get install --yes puppet-agent
    touch /home/vagrant/.provision.txt
fi

