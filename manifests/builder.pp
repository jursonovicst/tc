# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include tc::builder
class tc::builder {
  class { 'tc::builder::build':}
  -> class {'tc::builder::createrepo':
    reporoot => $tc::builder::build::reporoot
  }
}
