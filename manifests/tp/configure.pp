# @summary A short summary of the purpose of this class
#
# traffic portal config
#
# @example
#   include tc::tp::configure
class tc::tp::configure {
  # write config files
  File  <<| title == '/etc/traffic_portal/conf/config.js' |>> {
    notify => Service['traffic_portal']
  }
  File  <<| title == '/opt/traffic_portal/public/traffic_portal_properties.json' |>>{
    notify => Service['traffic_portal']
  }

  # restart service if needed
  Service { 'traffic_portal':
    ensure     => 'running',
    enable     => true,
    hasrestart => true,
  }
}


define tc::tp::configure::register_to (
  String $base_url = $title,
) {
  @@file { '/etc/traffic_portal/conf/config.js':
    ensure  => 'present',
    content => epp('tc/tp/config.js.epp', {
      'base_url' => $base_url,
      'sslkey'   => '/etc/traffic_portal/ssl/trafficportal.key',
      'sslcert'  => '/etc/traffic_portal/ssl/trafficportal.crt',
    }),
  }
  @@file { '/opt/traffic_portal/public/traffic_portal_properties.json':
    ensure  => present,
    content => epp('tc/tp/traffic_portal_properties.json.epp', { 'base_url' => $base_url }),
  }
}
