class python {
  $packages = [
    "build-essential",
    "python-dev",
    "python-setuptools",
    "python-psycopg2",
    "python-virtualenv",

    # Imaging
    "libpq-dev",
    "libjpeg62-dev",
    "zlib1g-dev",
    "libfreetype6-dev",
    "python-imaging",
  ]

  package {
    $packages: ensure => installed;
  }

  exec { "install-pip":
    path        => "/usr/local/bin:/usr/bin:/bin",
    refreshonly => true,
    command     => "easy_install pip",
    require     => Package["python-setuptools"],
    subscribe   => Package["python-setuptools"],
  }
}
