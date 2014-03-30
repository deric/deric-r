class r::repo(
  $manage_repo    = true,
  $package_source = 'r-project.org',
) {
  case $::osfamily {
    'Debian': {
      class { 'r::repo::debian':
        package_source => $package_source,
        manage_repo    => $manage_repo,
      }
    }
    default: {
      fail("Module ${module_name} is not supported on ${::osfamily}, os: ${::operatingsystem}")
    }
  }
}