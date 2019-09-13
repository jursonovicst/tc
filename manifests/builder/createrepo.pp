# @summary A short summary of the purpose of this class
#
# Creates a YUM repository with the traffic ops rmps.
#
# @example
#   include tc::builder::install
class tc::builder::createrepo (
  String $reporoot,
) {
  # install nginx
  include nginx

  # create yum repo
  nginx::resource::server { 'tcrepo':
    listen_options => 'default_server',
    www_root       => $reporoot,
  }

  # create repo
  createrepo { 'tcrepo':
    repository_dir   => $reporoot,
    manage_repo_dirs => false,
  }

  # export repo for collection on the tc nodes
  @@tc::builder::repo { "http://${facts['ipaddress']}": }
}
