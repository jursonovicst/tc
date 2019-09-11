# @summary A short summary of the purpose of this defined type.
#
# Exported yumrepo resource to collect on the tc nodes.
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
