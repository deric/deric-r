# == Class: r
#
# Manages R packages
#
# === Parameters
#   [ensure] - package version or 'present',
#             for removal set to 'absent'
#
# === Examples
#
#  class { r:
#    ensure => '2.15'
#  }
#
# === Authors
#
# Tomas Barton <barton.tomas@gmail.com>
#
# === Copyright
#
# Copyright 2014 Tomas Barton, unless otherwise noted.
#
class r(
  $ensure         = 'present',
  $manage_repo    = true,
  $package_source = 'r-project.org',
  ) {

  class { 'r::repo':
    manage_repo    => $manage_repo,
    package_source => $package_source,
  }

  package { 'r-base':
    ensure  => $ensure,
    require => Class['r::repo']
  }

  package { 'r-base-dev':
    require => [Package['r-base'], Class['r::repo']]
  }

}
