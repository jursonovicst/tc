# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include tc
class tc (
  String $rolefile = '/etc/tcrole'
) {
  # classify node
  if !$facts['tcrole'] {
    file { '/tmp/role.txt':
      content => "I have no role, file ${rolefile} probably does not exist!\n"
    }
  } else {
    class { 'motd':
      content => "*********************\n I am ${facts['tcrole']}\n*********************\n",
    }

    if $facts['tcrole'] == 'trafficopsdb' {
      include tc::todb
    } elsif $facts['tcrole'] == 'trafficops' {
      include tc::to
    } elsif $facts['tcrole'] == 'trafficportal' {
      include tc::tp
    } elsif $facts['tcrole'] == 'builder' {
      include tc::builder
    } else {
      class { 'motd':
        content => "*********************\n I have an unknown role: ${facts['tcrole']}\n*********************\n",
      }
    }
  }
}
