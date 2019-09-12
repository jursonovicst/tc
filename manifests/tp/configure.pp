# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include tc::tp::configure
class tc::tp::configure {
  File  <<| title == '/etc/traffic_portal/conf/config.js' |>> {
    notify => Service['traffic_portal']
  }
  File  <<| title == '/opt/traffic_portal/public/traffic_portal_properties.json' |>>{
    notify => Service['traffic_portal']
  }
  Service { 'traffic_portal':
    ensure     => 'running',
    enable     => true,
    hasrestart => true,
  }
}


define tc::tp::configure::register_to (
  String $base_url = $title,
  Integer $port    = 8080,
) {
  @@file { '/etc/traffic_portal/conf/config.js':
    ensure  => 'present',
    content => epp('tc/tp/config.js.epp', { 'base_url' => $base_url, 'port' => $port }),
  }
  @@file { '/opt/traffic_portal/public/traffic_portal_properties.json':
    ensure  => present,
    content => epp('tc/tp/traffic_portal_properties.json.epp', { 'base_url' => $base_url }),
  }
}
