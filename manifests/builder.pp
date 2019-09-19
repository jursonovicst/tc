# @summary A short summary of the purpose of this class
#
# Builds the traffic control packages and creates a yum repository to install them.
#
# @example
#   include tc::builder
class tc::builder {
  class { 'tc::builder::build': }
  -> class { 'tc::builder::createrepo':
    reporoot => $tc::builder::build::reporoot
  }
}
