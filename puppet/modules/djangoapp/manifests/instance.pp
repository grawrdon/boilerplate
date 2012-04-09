define djangoapp::instance(
  $project_name="",
  $production_domain="",
  $staging_domain="",
  $owner="www-data",
  $group="www-data",
  $static_url="/static/",
  $media_url="/media/",
  $git_checkout_url="",
  $requirements=true) {

  # If you add any more path variables,
  # KEEP A TRAILING SLASH!!

  $project_path = "/opt/${project_name}/"
  $venv_path = "${project_path}venv/"
  $src_path = "${project_path}src/"
  $requirements_file = "${project_path}requirements/common.txt"

  $development_static_path = "${project_path}static/"
  $development_media_path = "${project_path}media/"
  $production_static_path = "${project_path}static/"
  $production_media_path = "${project_path}media/"

  $server_type = $machine::server_type

  if !defined(File[$project_path]) {

      # Create project level directories.

      file { $project_path:
          ensure  => directory,
          owner   => $owner,
          group   => $group,
          mode    => 775,
          require => File[$client_path],
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

  # Create the wsgi file.
  gunicorn::setup { $project_wsgi_path:
    venv_path               => $venv_path,
    server_type             => $server_type,
    python_dir_name         => $python_dir_name,
    deployment_current_path => $deployment_current_path,
    deployment_etc_path     => $deployment_etc_path,
    owner                   => $owner,
    group                   => $group,
  }

  # Create a virtualenv and run the requirements file.
  pyenv::setup { $venv_path:
    requirements      => true,
    requirements_file => $requirements_file,
  }

  # Create the site specific nginx conf.
  nginx::site { $project_name:
    production_domain => $production_domain,
    staging_domain => $staging_domain,
    owner => $owner,
    group => $group,
    media_url => $media_url,
    static_url => $static_url,
  }

  # Create the MySQL database, this will do
  # nothing if it already exists.
  postgres::createdb { $project_name:
    db_name => $project_name,
    db_user => $project_name,
    db_pass => $project_name,
  }

  # Here we split depending on if this is a Vagrant
  # machine or our actual staging/production.
  if ( $server_type == 'vagrant' ) {
    djangoapp::development::setup { $full_project_name:
      project_path => $project_path,
      src_path     => $src_path,
      owner        => "deployer",
      group        => $group,
    }
  } else {
    djangoapp::production::setup { $full_project_name:
      project_path => $project_path,
      src_path     => $src_path,
      owner        => "deployer",
      group        => $group,
    }
  }
}
