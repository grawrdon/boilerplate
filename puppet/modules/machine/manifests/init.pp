class machine {
  if ( 'vagrant' in $hostname ) {
    $server_type = 'vagrant'
  } else {
    $server_type = 'server'
  }
}
