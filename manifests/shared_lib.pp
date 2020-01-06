# @summary Downloads and installs a file into solr's lib directory.
#
# @param [String] url
#   A file to download and install to the solr's lib directory.
#
# @param [Optional[String]] filename
#   If the name of the file is to be different than the filename from the
#   the url, the name of the file can be set.
#
# @param [String] path
#   The path to copy the file.
#   If setting a custom path, this module does not handle
#   maintaining the path, this is up to the calling module.
#
# @param [Optional[String]] web_user
#   The user name of the url to download.
#
# @param [Optional[String]] web_password
#   The user's password to download the file.
#
define solr::shared_lib (
  String           $url,
  Optional[String] $filename     = undef,
  String           $path         = $solr::solr_lib_dir,
  Optional[String] $web_user     = undef,
  Optional[String] $web_password = undef,
){

  # variables
  if $filename {
    $lib_name       = $filename
  }else {
    $lib_name_array = split($url,'/')
    $lib_name       = $lib_name_array[-1]
  }

  archive{"${path}/${lib_name}":
    source   => $url,
    user     => $web_user,
    password => $web_password,
  }
}
