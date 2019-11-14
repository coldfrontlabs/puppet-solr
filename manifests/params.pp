# @summary Dynamic parameters for the solr class.
#
class solr::params (
){

  # OS Specific configuration
  case $::osfamily {
    'RedHat': {
      $required_packages  = ['java-1.8.0-openjdk','unzip','lsof']
      $java_home = '/usr/lib/jvm/jre-1.8.0'
      $solr_env = '/etc/sysconfig/solr'
      if versioncmp($::operatingsystemrelease, '7.0') >= 0 {
        $is_systemd = true
      } else {
        $is_systemd = false
      }
    }
    'debian':{
      $java_home = '/usr/lib/jvm/java-8-openjdk-amd64/jre'
      $solr_env = '/etc/default/solr'
      if $::operatingsystem == 'Ubuntu' and
      versioncmp($::operatingsystemrelease, '15.04') >= 0 {
        $is_systemd = true
        $required_packages = ['unzip','lsof','software-properties-common', 'openjdk-8-jre']
      } else {
        $is_systemd = false
        $required_packages = ['unzip','lsof','openjdk-8-jre']
      }
    }
    default: {
      fail("Unsupported OS ${::osfamily}.\
  Please use a debian or redhat based system")
    }
  }
}
