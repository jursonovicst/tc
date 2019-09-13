# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include tc::tp::install
class tc::tp::install (
  String $nodejssetupscript = '/tmp/setup_6.x',
) {
  include ::openssl

  file { $nodejssetupscript:
    ensure => 'present',
    source => 'https://rpm.nodesource.com/setup_6.x',
    mode   => '0755',
  }
  ~> exec { $nodejssetupscript:
    refreshonly => true,
  }
  -> Tc::Builder::Repo <<|  |>>
  -> Package { 'traffic_portal':
    ensure => 'latest'
  }
  -> file {'/etc/traffic_portal/ssl':
    ensure => 'directory'
  }
  -> openssl::certificate::x509 { 'trafficportal':
    ensure       => present,
    country      => 'DE',
    organization => 'la.t-online.de',
    commonname   => "localhost",
#    state        => 'Here',
#    locality     => 'Myplace',
#    unit         => 'MyUnit',
#    altnames     => ['a.com', 'b.com', 'c.com'],
#    extkeyusage  => ['serverAuth', 'clientAuth', 'any_other_option_per_openssl'],
#    email        => 'contact@foo.com',
    days         => 3456,
    base_dir     => '/etc/traffic_portal/ssl',
#    owner        => 'www-data',
#    group        => 'www-data',
#    password     => 'j(D$',
#    force        => false,
#    cnf_tpl      => 'my_module/cert.cnf.erb'
  }
}
