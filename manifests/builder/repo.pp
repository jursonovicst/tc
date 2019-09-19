# @summary A short summary of the purpose of this defined type.
#
# Install traffic control repo.
#
# @example
#   tc::builder::repo { 'namevar': }
define tc::builder::repo (
  String $baseurl = $title
) {
  yumrepo { 'tcrepo':
    baseurl  => $baseurl,
    gpgcheck => false,
  }
}
