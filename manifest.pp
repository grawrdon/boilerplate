$server_admin_email = "webmaster@example.com"

$project_name = "projectname"

$production_domain = "example.com"
$media_url = "/media/"
$static_url = "/static/"
$git_checkout_url = "git@github.com:user/megacorp_enterprise.git"

package {
  "git-core":
    ensure => installed;
}

group { "puppet":
  ensure => "present",
}

include python
include nginx
include djangoapp

djangoapp::instance { "instance_name":
  project_name      => $project_name,
  production_domain => $production_domain,
  git_checkout_url  => $git_checkout_url,
  media_url         => $media_url,
  static_url        => $static_url
}
