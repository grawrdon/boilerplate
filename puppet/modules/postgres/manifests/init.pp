# Copyright (c) 2008, Luke Kanies, luke@madstop.com
#
# Permission to use, copy, modify, and/or distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
class postgres (
  $version='8.4') {

  package { ["postgresql"]: ensure => installed }

    service { "postgresql-${version}":
      ensure     => running,
      enable     => true,
      hasstatus  => true,
      hasrestart => true,
      subscribe  => Package["postgresql"]
    }

    file { 'pg_hba.conf':
      path    => "/etc/postgresql/${version}/main/pg_hba.conf",
      source  => 'puppet:///modules/postgres/pg_hba.conf',
      mode    => '0640',
      owner   => 'postgres',
      require => Package["postgresql"],
    }
}
