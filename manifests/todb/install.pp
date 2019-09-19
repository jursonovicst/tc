# @summary A short summary of the purpose of this class
#
# postgresql install
#
# @example
#   include tc::todb::install
class tc::todb::install (
  String $pgPassword,
  String $pgUser    = 'postgres',
  String $pgVersion = '9.6',
) {
  # set pg version and repo
  class { 'postgresql::globals':
    manage_package_repo => true,
    version             => $pgVersion,
  }

  # install pg
  class { 'postgresql::server':
    user                    => $pgUser,
    postgres_password       => $pgPassword,
    ip_mask_allow_all_users => '10.0.0.0/16',
    ipv4acls                => ['host all all 10.0.0.0/16 md5'],
    listen_addresses        => '0.0.0.0',
  }

  # register database for traffic ops
  -> tc::to::configure::register_todb { $facts['ipaddress']:
    pgUser     => $pgUser,
    pgPassword => $pgPassword,
  }
}
