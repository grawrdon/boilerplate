define pyenv::setup(
  $requirements=undef,
  $common_requirements_file="",
  $dev_requirements_file="") {

  $venv_path = $name

  exec { "pyenv::setup ${venv_path}":
    command => "virtualenv ${venv_path}",
    creates => $venv_path,
    path    => "/usr/local/bin:/usr/bin:/bin",
    notify  => [
      Exec["update distribute and pip in $venv_path"],
      Exec["pyenv::requirements $venv_path"],
    ],
    require => [
      Package["python-virtualenv"],
    ]
  }

  # Change ownership of the venv after its created.
  exec { "pyenv::setup $venv_path chown":
    command     => "chown -R www-data:www-data $venv_path",
    path        => "/usr/local/bin:/usr/bin:/bin",
    refreshonly => true,
    require     => Exec["pyenv::setup ${venv_path}"],
    subscribe   => Exec["pyenv::setup ${venv_path}"],
  }

# Some newer Python packages require an updated distribute
# from the one that is in repos on most systems:
  exec { "update distribute and pip in $venv_path":
    command => "${venv_path}bin/pip install -U distribute pip",
    refreshonly => true,
  }

  if ($requirements) {
    exec { "pyenv::requirements $venv_path":
      command     => "${venv_path}bin/pip install -r $common_requirements_file",
      logoutput   => true,
      refreshonly => true,
      require     => [
        Exec["pyenv::setup ${venv_path}"],
      ]
    }
  }
}
