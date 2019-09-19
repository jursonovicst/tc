# @summary A short summary of the purpose of this class
#
# traffic ops install
#
# @example
#   include tc::to::install
class tc::to::install (
) {
  include '::cpan'

  # add epel repo
  yum::install { 'epel-release-7-11':
    ensure => present,
    source => 'http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm',
  }

  # set pg version and add repo
  class { 'postgresql::globals':
    manage_package_repo => true,
    version             => $tc::todb::install::pgVersion,
  }
  #-> yum::install { 'pgdg-redhat-repo-42.0-4':
  #  ensure => present,
  #  source => 'https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm',
  #}

  # add our own traffic control repo
  -> Tc::Builder::Repo <<|  |>>

  # install traffic ops
  -> Package { 'traffic_ops':
    ensure => 'latest'
  }

  # install additional cpan requisites
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