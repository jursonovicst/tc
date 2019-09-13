# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include tc::puppet
class tc::pm (
  String $sqsurl,
  String $region,
){
  Package { 'python3-boto3':
    ensure => 'latest'
  }
  -> File { '/opt/tc/removenodes.py':
    ensure => present,
    source => 'puppet:///modules/tc/pm/removenodes.py',
    mode   => '0755',
  }
  -> cron { 'removenodes':
    command => "/opt/tc/removenodes.py ${sqsurl} ${region}",
    user    => 'root',
  }
}
