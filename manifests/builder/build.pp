# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include tc::builder::build
class tc::builder::build (
  String $version = '3.0.2',
  String $trafficcontrolroot = '/opt/go/src/github.com/apache/trafficcontrol',
  String $reporoot = "${trafficcontrolroot}/dist"
){
  file {'/etc/yum.repos.d/docker-ce.repo':
    ensure => 'present',
    source => 'https://download.docker.com/linux/centos/docker-ce.repo',
  }
  -> package {['docker-ce', 'docker-ce-cli', 'containerd.io', 'git']:
    ensure => 'latest'
  }
  -> archive { '/opt/go1.13.linux-amd64.tar.gz':
    source        => 'https://dl.google.com/go/go1.13.linux-amd64.tar.gz',
    extract       => true,
    extract_path  => '/opt',
  }
  -> service {'docker':
    ensure     => 'running',
    enable     => true,
  }
  -> vcsrepo { $trafficcontrolroot:
    ensure   => present,
    provider => git,
    source   => 'https://github.com/apache/trafficcontrol.git',
    revision => "RELEASE-${version}",
  }

  exec { 'traffic_stats_build':
    command     => "${trafficcontrolroot}/pkg -v traffic_stats_build",
    cwd         => $trafficcontrolroot,
    refreshonly => true,
    logoutput   => true,
    timeout     => 600,
    subscribe   => Vcsrepo[$trafficcontrolroot]
  }
  exec { 'traffic_router_build':
    command     => "${trafficcontrolroot}/pkg -v traffic_router_build",
    cwd         => $trafficcontrolroot,
    refreshonly => true,
    logoutput   => true,
    timeout     => 600,
    subscribe   => Vcsrepo[$trafficcontrolroot]
  }
  exec { 'traffic_monitor_build':
    command     => "${trafficcontrolroot}/pkg -v traffic_monitor_build",
    cwd         => $trafficcontrolroot,
    refreshonly => true,
    logoutput   => true,
    timeout     => 600,
    subscribe   => Vcsrepo[$trafficcontrolroot]
  }
  exec { 'traffic_ops_build':
    command     => "${trafficcontrolroot}/pkg -v traffic_ops_build",
    cwd         => $trafficcontrolroot,
    refreshonly => true,
    logoutput   => true,
    timeout     => 600,
    subscribe   => Vcsrepo[$trafficcontrolroot]
  }
  exec { 'traffic_portal_build':
    command     => "${trafficcontrolroot}/pkg -v traffic_portal_build",
    cwd         => $trafficcontrolroot,
    refreshonly => true,
    logoutput   => true,
    timeout     => 600,
    subscribe   => Vcsrepo[$trafficcontrolroot]
  }
}
