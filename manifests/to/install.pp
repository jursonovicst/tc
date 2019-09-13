# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include tc::to::install
class tc::to::install (
) {
  include '::cpan'
  yum::install { 'epel-release-7-11':
    ensure => present,
    source => 'http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm',
  }
  -> yum::install { 'pgdg-redhat-repo-42.0-4':
    ensure => present,
    source => 'https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm',
  }
  #  -> yum::install { 'traffic_ops':
  #    ensure => present,
  #    source => "https://builds.apache.org/job/trafficcontrol-master-build/lastStableBuild/artifact/dist/traffic_ops-${
  #      tc::to::buildversion}.el7.x86_64.rpm",
  #  }
  -> Tc::Builder::Repo <<|  |>>
  -> Package { 'traffic_ops':
    ensure => 'latest'
  }
  -> cpan { "IPC::Run3":
    ensure  => present,
    require => Class['::cpan'],
    force   => true,
  }
  -> cpan { "String::ShellQuote":
    ensure  => present,
    require => Class['::cpan'],
    force   => true,
  }
}