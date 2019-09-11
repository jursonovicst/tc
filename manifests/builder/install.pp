# @summary A short summary of the purpose of this class
#
# Creates a YUM repository with the traffic ops rmps.
#
# @example
#   include tc::builder::install
class tc::builder::install (
  String $wwwroot        = "/usr/share/nginx/tcrepo",
  String $tcbuildversion = '3.0.0-10181.b19491d3.el7.x86_64',
) {
  # install nginx
  include nginx

  # create yum repo
  file { ['/var/cache/yumrepos', '/var/cache/yumrepos/tcrepo', $wwwroot]:
    ensure => 'directory',
  }
  -> nginx::resource::server { 'tcrepo':
    listen_options => 'default_server',
    www_root       => $wwwroot,
  }

  # download traffic control rmps
  file { "${wwwroot}/traffic_ops-${tcbuildversion}.rpm":
    ensure  => present,
    source  => "https://builds.apache.org/job/trafficcontrol-master-build/lastStableBuild/artifact/dist/traffic_ops-${tcbuildversion}.rpm",
    require => Nginx::Resource::Server['tcrepo'],
    notify  => Createrepo['tcrepo'],
  }
  file { "${wwwroot}/traffic_portal-${tcbuildversion}.rpm":
    ensure  => present,
    source  => "https://builds.apache.org/job/trafficcontrol-master-build/lastStableBuild/artifact/dist/traffic_portal-${tcbuildversion}.rpm",
    require => Nginx::Resource::Server['tcrepo'],
    notify  => Createrepo['tcrepo'],
  }
  file { "${wwwroot}/traffic_router-${tcbuildversion}.rpm":
    ensure  => present,
    source  => "https://builds.apache.org/job/trafficcontrol-master-build/lastStableBuild/artifact/dist/traffic_router-${tcbuildversion}.rpm",
    require => Nginx::Resource::Server['tcrepo'],
    notify  => Createrepo['tcrepo'],
  }
  file { "${wwwroot}/traffic_monitor-${tcbuildversion}.rpm":
    ensure  => present,
    source  => "https://builds.apache.org/job/trafficcontrol-master-build/lastStableBuild/artifact/dist/traffic_monitor-${tcbuildversion}.rpm",
    require => Nginx::Resource::Server['tcrepo'],
    notify  => Createrepo['tcrepo'],
  }
  file { "${wwwroot}/traffic_stats-${tcbuildversion}.rpm":
    ensure  => present,
    source  => "https://builds.apache.org/job/trafficcontrol-master-build/lastStableBuild/artifact/dist/traffic_stats-${tcbuildversion}.rpm",
    require => Nginx::Resource::Server['tcrepo'],
    notify  => Createrepo['tcrepo'],
  }

  # create repo
  createrepo { 'tcrepo':
    repository_dir   => $wwwroot,
    manage_repo_dirs => false,
  }

  # export repo for collection on the tc nodes
  @@tc::builder::repo { "http://${facts['ipaddress']}": }
}
