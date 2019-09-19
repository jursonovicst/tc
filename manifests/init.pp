# @summary A short summary of the purpose of this class
#
# This class installs the required traffic control role according to the /etc/tcrole sprcification.
#
# @example
#   include tc
class tc (
  String $rolefile = '/etc/tcrole'
) {
  # classify node
  if !$facts['tcrole'] {
    notify { "I, $hostname have no tcrole fact, ${rolefile} probably does not exist!": }

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
    } elsif $facts['tcrole'] == 'trafficmonitor' {
      include tc::tm
    } elsif $facts['tcrole'] == 'trafficrouter' {
      include tc::tr
    } elsif $facts['tcrole'] == 'builder' {
      include tc::builder
    } else {
      class { 'motd':
        content => "*********************\n I have an unknown role: ${facts['tcrole']}\n*********************\n",
      }
    }
  }
}
