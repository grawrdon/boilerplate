$server_admin_email = "webmaster@example.com"
$project_name       = "boilerplate"
$production_domain  = "example.com"
$staging_domain     = "staging.example.com"
$media_url          = "/media/"
$static_url         = "/static/"
$git_checkout_url   = "git@github.com:tylerball/boilerplate.git"
$db_pass            = 'test'

package {
  "git-core":
    ensure => installed;
}

group { "puppet":
  ensure => "present",
}

include machine
include postgres
include python
include nginx
include djangoapp
include gunicorn

djangoapp::instance { "projectname_prod":
  project_name      => $project_name,
  production_domain => $production_domain,
  staging_domain    => $staging_domain,
  git_checkout_url  => $git_checkout_url,
  media_url         => $media_url,
  static_url        => $static_url,
  db_pass           => $db_pass,
}
