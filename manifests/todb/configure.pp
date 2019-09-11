# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include tc::todb::configure
class tc::todb::configure (
  String $toUser   = 'traffic_ops',
  String $toPassword,
  String $toDBname = 'traffic_ops',
) {
  postgresql::server::role { $toUser:
    password_hash => postgresql_password($toUser, $toPassword),
  }
  -> postgresql::server::db { $toDBname:
    user     => $toUser,
    password => postgresql_password($toUser, $toPassword),
    owner    => $toUser,
  }
  -> tc::to::configure::register_database { $toDBname:
    hostname => $facts['ipaddress'],
    user     => $toUser,
    password => $toPassword,
  }
}
