define djangoapp::development::setup ($project_path="",
                                      $src_path="",
                                      $owner="www-data",
                                      $group="www-data") {

    $project_name = $name


    file { "${project_path}current":
        path    => "${project_path}current",
        ensure  => link,
        target  => $src_path,
        owner   => $owner,
        group   =>  $group,
    }
}
