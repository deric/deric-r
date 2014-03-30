# This class file is not called directly
class r::repo::debian(
    $manage_repo    = true,
    $package_source = 'r-project.org',
  ) {

  if $caller_module_name != $module_name {
    warning("${name} is deprecated as a public API of the ${module_name} module and should no longer be directly included in the manifest.")
  }

  $codename = $::lsbdistcodename

  anchor { 'r::apt_repo' : }

  include '::apt'

  if $manage_repo {
    case $package_source {
      'r-project.org': {
        apt::source { 'r-project':
          location   => "http://cran.r-project.org/bin/linux/ubuntu ${codename}",
          repos      => 'r',
          notify     => Exec['apt_get_update_for_r'],
        }
      }
      default: {}
    }

    exec { 'apt_get_update_for_r':
      command     => '/usr/bin/apt-get update',
      timeout     => 240,
      returns     => [ 0, 100 ],
      refreshonly => true,
      before      => Anchor['r::apt_repo'],
    }
  }
}
