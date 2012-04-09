define pyenv::setup(
  $requirements=undef,
  $requirements_file="") {

  # TODO: Initial requirements loading?
  # Done with an internally build script for now..

  $venv_path = $name

  # Does not successfully run as deployer for some reason.
  exec { "pyenv::setup $venv_path":
    command => "virtualenv ${venv_path}",
    creates => $venv_path,
    path   => "/usr/local/bin:/usr/bin:/bin",
    notify => Exec["update distribute and pip in $venv_path"],
    require => pyenv::package,
  }

  # Change ownership of the venv after its created.
  exec { "pyenv::setup $venv_path chown":
    command => "chown -R deployer:www-data $venv_path",
    path   => "/usr/local/bin:/usr/bin:/bin",
    require => Exec["pyenv::setup $venv_path"],
  }

# Some newer Python packages require an updated distribute
# from the one that is in repos on most systems:
  exec { "update distribute and pip in $venv_path":
    command => "${venv_path}bin/pip install -U distribute pip",
    refreshonly => true,
  }

  if ($requirements) {
    exec { "pyenv::requirements $requirements_file":
      command     => "${venv_path}bin/pip install -r $requiments_file",
      refreshonly => true,

    }
  }
}
