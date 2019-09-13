# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include tc::todb
class tc::todb {
  class { 'tc::todb::install':}
  -> class { 'tc::todb::configure':}
}
