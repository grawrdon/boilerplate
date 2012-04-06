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

include python
