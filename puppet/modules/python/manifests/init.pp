class python {
  $packages = [
    "build-essential",
    "python-dev",
    "python-setuptools",
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
