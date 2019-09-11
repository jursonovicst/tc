# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include tc::todb::install
class tc::todb::install (
  String $pgUser    = 'postgres',
  String $pgPassword,
  String $pgVersion = '9.6'
) {
  class { 'postgresql::server':
    user                    => $pgUser,
    postgres_password       => $pgPassword,
    ip_mask_allow_all_users => '10.0.0.0/16',
    ipv4acls                => ['host all all 10.0.0.0/16 md5'],
    version                 => $pgVersion,
    listen_addresses        => '0.0.0.0',
  }
  -> tc::to::configure::register_dbconf { $facts['ipaddress']:
    pgUser     => $pgUser,
    pgPassword => $pgPassword,
  }

}
