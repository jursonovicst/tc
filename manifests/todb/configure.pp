# @summary A short summary of the purpose of this class
#
# postgresql config
#
# @example
#   include tc::todb::configure
class tc::todb::configure (
  String $toUser   = 'traffic_ops',
  String $toPassword,
  String $toDBname = 'traffic_ops',
) {
  # configure required roles for traffic ops
  postgresql::server::role { $toUser:
    password_hash => postgresql_password($toUser, $toPassword),
  }
  -> postgresql::server::db { $toDBname:
    user     => $toUser,
    password => postgresql_password($toUser, $toPassword),
    owner    => $toUser,
  }
  -> tc::to::configure::configure_todb { $toDBname:
    hostname => $facts['ipaddress'],
    user     => $toUser,
    password => $toPassword,
  }
}
