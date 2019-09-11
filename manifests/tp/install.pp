# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include tc::tp::install
class tc::tp::install (
  String $nodejssetupscript = '/tmp/setup_6.x'
) {
  file { $nodejssetupscript:
    ensure => 'present',
    source => 'https://rpm.nodesource.com/setup_6.x'
  }
  ~> exec { $nodejssetupscript:
    #TODO: add onlyif =>
  }
  -> Tc::Builder::Repo <<|  |>>
  -> Package { 'traffic_portal': }

  #->package {'nodejs':
  #  ensure => latest,
  #}
  #->yum::install { 'traffic_portal':
  #  ensure => present,
  #  source => "https://builds.apache.org/job/trafficcontrol-master-build/lastStableBuild/artifact/dist/traffic_portal-${tc::to::buildversion}.el7.x86_64.rpm",
  #}
  #-> service { 'traffic_portal':
  #  ensure => running,
  #  enable => true,
  #}
}
