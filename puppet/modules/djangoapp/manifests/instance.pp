define djangoapp::instance(
  $project_name="",
  $production_domain="",
  $staging_domain="",
  $owner="www-data",
  $group="www-data",
  $static_url="/static/",
  $media_url="/media/",
  $git_checkout_url="",
  $db_pass="",
  $requirements=true) {

  # If you add any more path variables,
  # KEEP A TRAILING SLASH!!

  $project_path = "/opt/${project_name}/"
  $venv_path = "${project_path}venv/"
  $common_requirements_file = "${project_path}current/requirements/common.txt"
  $dev_requirements_file = "${project_path}current/requirements/dev.txt"

  $development_static_path = "${project_path}static/"
  $development_media_path = "${project_path}media/"
  $production_static_path = "${project_path}static/"
  $production_media_path = "${project_path}media/"

  $server_type = $machine::server_type

  # Here we split depending on if this is a Vagrant
  # machine or our actual staging/production.
  if ( $server_type == 'vagrant' ) {
    $src_path = "/vagrant"

    djangoapp::development::setup { $full_project_name:
      project_path => $project_path,
      src_path     => $src_path,
      owner        => "www-data",
      group        => $group,
    }
  } else {
    $src_path = "${project_path}src/"

    djangoapp::production::setup { $full_project_name:
      project_path => $project_path,
      src_path     => $src_path,
      owner        => "www-data",
      group        => $group,
    }
  }

  if defined(File[$project_path]) {

    file { $project_path:
      ensure => directory,
      owner => $owner,
      group => $group,
      mode => 775,
      require => File["/opt/"],
    }

    if ( $server_type != 'vagrant') {

      file { $production_static_path:
          ensure  => directory,
          owner   => $owner,
          group   => $group,
          mode    => 664, # rw, rw, r
          require => File[$project_path],
      }

      file { $production_media_path:
          ensure  => directory,
          owner   => $owner,
          group   => $group,
          mode    => 664, # rw, rw, r
          require => File[$project_path],
      }
    }
  }

  # Create a virtualenv and run the requirements file.
  pyenv::setup { $venv_path:
    requirements      => true,
    common_requirements_file => $common_requirements_file,
    dev_requirements_file => $dev_requirements_file,
  }

  # Create the wsgi file.
  #gunicorn::instance { $project_name:
    #venv_path               => $venv_path,
    #server_type             => $server_type,
    #python_dir_name         => $python_dir_name,
    #deployment_current_path => $deployment_current_path,
    #deployment_etc_path     => $deployment_etc_path,
    #owner                   => $owner,
    #group                   => $group,
  #}

  # Create the site specific nginx conf.
  nginx::site { $project_name:
    production_domain => $production_domain,
    staging_domain => $staging_domain,
    owner => $owner,
    group => $group,
    media_url => $media_url,
    static_url => $static_url,
  }

  postgres::role { $project_name:
    ensure   => "present",
    password => $db_pass,
  }

  postgres::database { "${project_name}_staging":
    ensure => "present",
    owner  => $project_name,
  }

  postgres::database { "${project_name}_live":
    ensure => "present",
    owner  => $project_name,
  }
}
