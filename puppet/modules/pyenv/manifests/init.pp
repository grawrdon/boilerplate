class pyenv {
  $latest_packages = [
    "virtualenv",
    "virtualenvwrapper",
  ]

  package {
    $packages: ensure => installed, provider => pip;
  }
}
