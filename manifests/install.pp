# @summary Installs the packages and software that support solr.
#
class solr::install {

  # == variables == #
  # The destination full path to the solr tarball.
  $tarball = "${solr::solr_downloads}/solr-${solr::version}.tgz"

  # install requirements
  ensure_packages($solr::required_packages)

  # Install java if desired.
  if ($solr::manage_java) {
    ensure_packages($solr::java_packages)
  }

  ## create a solr user
  user {$solr::solr_user:
    ensure     => present,
    home       => $solr::var_dir,
    system     => true,
    managehome => true,
    shell      => '/bin/bash',
    require    => Package[$solr::required_packages],
  }

  # directory to store downloaded solr versions and install to
  file { $solr::solr_downloads:
    ensure => directory,
  }

  if $solr::install_dir_mg{
    file { $solr::install_dir:
      ensure => directory,
      before => Exec['install_solr_service.sh'],
    }
  }

  # download solr
  archive{$tarball:
    source  => "${solr::url}/${solr::version}/solr-${solr::version}.tgz",
    require => File[$solr::solr_downloads],
  }

  # extract install script
  exec {'extract install script':
    command     => "/bin/tar -C ${solr::solr_downloads} -xf ${tarball}\
  solr-${solr::version}/bin/install_solr_service.sh --strip-components=2",
    refreshonly => true,
    subscribe   => Archive[$tarball],
  }

  # run install script
  exec {'install_solr_service.sh':
    command     => "${solr::solr_downloads}/install_solr_service.sh\
  \"${tarball}\" -f -i \"${solr::install_dir}\" -d \"${solr::var_dir}\"\
 -u ${solr::solr_user} -p ${solr::solr_port}",
    refreshonly => true,
    subscribe   => Exec['extract install script'],
    require     =>  User[$solr::solr_user]
  }
}
