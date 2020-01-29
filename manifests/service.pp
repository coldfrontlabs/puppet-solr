# @summary Manages the service for solr.
#
class solr::service {
  service { 'solr':
    ensure => running,
    enable => true,
  }
}
