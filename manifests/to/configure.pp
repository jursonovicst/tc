# @summary A short summary of the purpose of this class
#
# traffic ops config
#
# @example
#   include tc::to::configure
#require tc::to::install

class tc::to::configure (
  String $tmAdminPw,
  String $dns_subdomain,
  String $cdn_name,
  String $base_url    = "https://${facts['ipaddress']}",
  String $to_custom   = '/tmp/to_custom.json',
  String $tmAdminUser = 'admin',
) {
  # create traffic ops postinstall config file
  concat { $to_custom:
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    notify => Exec['postinstall']
  }
  concat::fragment { 'to_header':
    target  => $to_custom,
    content => epp('tc/to/to_defaults.head.epp', {
      'tm_url'        => $base_url,
      'cdn_name'      => $cdn_name,
      'dns_subdomain' => $dns_subdomain,
      'tmAdminUser'   => $tmAdminUser,
      'tmAdminPw'     => $tmAdminPw
    }),
    order   => '01',
  }
  Concat::Fragment  <<| title == 'to_dbconf2' |>> {
    target => $to_custom,
    order  => '02',
  }
  Concat::Fragment  <<| title == 'to_database2' |>> {
    target => $to_custom,
    order  => '03',
  }
  concat::fragment { 'to_tail':
    target  => $to_custom,
    content => "}\n",
    order   => '04',
  }

  # run postinstall only, if config file changed, script is slow, use a long timeout
  exec { 'postinstall':
    command     => "/opt/traffic_ops/install/bin/postinstall -cfile ${to_custom}",
    refreshonly => true,
    logoutput   => true,
    timeout     => 600,
  }

  # register traffic ops for traffic portal and traffic monitor
  tc::tp::configure::register_to { $base_url:
    require => Exec['postinstall']
  }
  tc::tm::configure::register_to { $base_url:
    username => $tmAdminUser,
    password => $tmAdminPw,
    insecure => false,
    cdnName  => $cdn_name,
    require  => Exec['postinstall']
  }
}


define tc::to::configure::register_todb (
  String $pgUser,
  String $pgPassword,
) {
  @@concat::fragment { 'to_dbconf2':
    target  => 'dummy', # will be overwritten at collection
    content => epp('tc/to/to_defaults.dbconf.epp', { 'pgUser' => $pgUser, 'pgPassword' => $pgPassword }),
  }
}


define tc::to::configure::configure_todb (
  String $hostname,
  String $user,
  String $password,
  String $dbname = $title,
) {
  @@concat::fragment { 'to_database2':
    target  => 'dummy', # will be overwritten at collection
    content => epp('tc/to/to_defaults.database.epp', { 'dbname' => $dbname, 'hostname' => $hostname, 'user' => $user,
      'password'                                                => $password }),
  }
}