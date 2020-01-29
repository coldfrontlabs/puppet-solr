# @summary Sets up a core based on the example core installed by default.
#
# @param [String] core_name
#   The name of the core (must be unique).
#
# @param [Boolean] replace
#   Whether or not files should be updated if they are different from the source
#   specified.
#
# @param [String] currency_src_file
#   The currency file for the core.  It can either be a local file
#   (managed outside of this module) or a remote file served through a puppet
#   file server (puppet:///).
#
# @param [Array] other_files
#   An array of hashes to create file resources.
#
# @param [String] protwords_src_file
#   The schema file for the core.  It can either be a local file
#   (managed outside of this module) or a remote file served through a puppet
#   file server (puppet:///).
#
# @param [String] schema_src_file
#   The schema file for the core.  It can either be a local file
#   (managed outside of this module) or a remote file served through a puppet
#   file server (puppet:///).
#
# @param [String] solrconfig_src_file
#   The schema file for the core.  It can either be a local file
#   (managed outside of this module) or a remote file served through a puppet
#   file server (puppet:///).
#
# @param [String] stopwords_src_file
#   The schema file for the core.  It can either be a local file
#   (managed outside of this module) or a remote file served through a puppet
#   file server (puppet:///).
#
# @param [String] synonyms_src_file
#   The schema file for the core.  It can either be a local file
#   (managed outside of this module) or a remote file served through a puppet
#   file server (puppet:///).
#
# @param [String] elevate_src_file
#   The elevate file for the core.  It can either be a local file
#   (managed outside of this module) or a remote file served through a puppet
#   file server (puppet:///).
#
define solr::core (
  String  $core_name                  = $title,
  Boolean $replace                    = true,
  Optional[String] $currency_src_file = undef,
  Array   $other_files                = [],
  String  $protwords_src_file         = "${::solr::basic_dir}/protwords.txt",
  String  $schema_src_file            = "${::solr::basic_dir}/${solr::schema_filename}",
  String  $solrconfig_src_file        = "${::solr::basic_dir}/solrconfig.xml",
  String  $stopwords_src_file         = "${::solr::basic_dir}/stopwords.txt",
  String  $synonyms_src_file          = "${::solr::basic_dir}/synonyms.txt",
  Optional[String] $elevate_src_file  = undef,
){

# "${::solr::basic_dir}/currency.xml",
# "${::solr::basic_dir}/elevate.xml",

  # The base class must be included first because core uses variables from
  # base class
  if ! defined(Class['solr']) {
    fail('You must include the solr base class before using any solr defined resources')
  }

  $dest_dir    = "${::solr::solr_core_home}/${core_name}"
  $conf_dir    = "${dest_dir}/conf"
  $schema_file = "${conf_dir}/${solr::schema_filename}"

  # check solr version
  # parse the version to get first
  $version_array = split($::solr::version,'[.]')
  $ver_major = $version_array[0]+0

  file { $dest_dir:
    ensure  => directory,
    owner   => $::solr::solr_user,
    group   => $::solr::solr_user,
    require => Class['solr::config'],
  }

  # create the conf directory
  file { $conf_dir:
    ensure  => directory,
    owner   => $::solr::solr_user,
    group   => $::solr::solr_user,
    require => File[$dest_dir],
  }

  file { "${conf_dir}/solrconfig.xml":
    ensure  => file,
    owner   => $::solr::solr_user,
    group   => $::solr::solr_user,
    source  => $solrconfig_src_file,
    replace => $replace,
    require => File[$conf_dir],
    notify  => Class['solr::service'],
  }

  file { "${conf_dir}/synonyms.txt":
    ensure  => file,
    owner   => $::solr::solr_user,
    group   => $::solr::solr_user,
    source  => $synonyms_src_file,
    replace => $replace,
    require => File["${conf_dir}/solrconfig.xml"],
    notify  => Class['solr::service'],
  }

  file { "${conf_dir}/protwords.txt":
    ensure  => file,
    owner   => $::solr::solr_user,
    group   => $::solr::solr_user,
    source  => $protwords_src_file,
    replace => $replace,
    require => File["${conf_dir}/synonyms.txt"],
    notify  => Class['solr::service'],
  }

  file { "${conf_dir}/stopwords.txt":
    ensure  => file,
    owner   => $::solr::solr_user,
    group   => $::solr::solr_user,
    source  => $stopwords_src_file,
    replace => $replace,
    require => File["${conf_dir}/protwords.txt"],
    notify  => Class['solr::service'],
  }

  exec { "${core_name}_copy_lang":
    command => "/bin/cp -r ${::solr::basic_dir}/lang ${conf_dir}/.",
    user    => $::solr::solr_user,
    creates => "${conf_dir}/lang/stopwords_en.txt",
    require => File["${conf_dir}/stopwords.txt"],
    notify  => Class['solr::service'],
  }

  if $currency_src_file {
    file { "${conf_dir}/currency.xml":
      ensure  => file,
      owner   => $::solr::solr_user,
      group   => $::solr::solr_user,
      source  => $currency_src_file,
      replace => $replace,
      require => Exec["${core_name}_copy_lang"],
      notify  => Class['solr::service'],
    }
  }

  if $elevate_src_file {
    file { "${conf_dir}/elevate.xml":
      ensure  => file,
      owner   => $::solr::solr_user,
      group   => $::solr::solr_user,
      source  => $elevate_src_file,
      replace => $replace,
      require => Exec["${core_name}_copy_lang"],
      notify  => Class['solr::service'],
    }
  }

  file { $schema_file:
    ensure  => file,
    owner   => $::solr::solr_user,
    group   => $::solr::solr_user,
    source  => $schema_src_file,
    replace => $replace,
    require => Exec["${core_name}_copy_lang"],
    notify  => Class['solr::service'],
  }

  $defaults = {
    'ensure'  => file,
    'owner'   => $::solr::solr_user,
    'group'   => $::solr::solr_user,
    'replace' => $replace,
    'require' => File[$conf_dir],
    'notify'  => Class['solr::service'],
    'before'  => File["${dest_dir}/core.properties"],
  }
  create_resources(file, other_files($other_files, $conf_dir), $defaults)

  file { "${dest_dir}/core.properties":
    ensure  => file,
    content => inline_template(
"name=${core_name}
config=solrconfig.xml
schema=${solr::schema_filename}
dataDir=data"),
    require => File[$schema_file],
    notify  => Service['solr'],
  }

}
