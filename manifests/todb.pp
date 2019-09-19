# @summary A short summary of the purpose of this class
#
# Prepares the postgresql database for traffic ops.
#
# @example
#   include tc::todb
class tc::todb {
  class { 'tc::todb::install': }
  -> class { 'tc::todb::configure': }
}
