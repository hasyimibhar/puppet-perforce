class perforce::server (
  $user,
  $password,
  $p4root,
  $p4journal,
  $p4err,
  $p4port
) {

  user { $user:
    ensure     => present,
    home       => "/var/local/$user",
    password   => $password,
    managehome => true,
    system     => true,
  }

  exec { 'p4d':
    command => 'wget http://www.perforce.com/downloads/perforce/r15.1/bin.linux26x86_64/p4d',
    path => '/usr/local/bin:/usr/bin:/bin',
    cwd => '/usr/local/bin',
    creates => '/usr/local/bin/p4d',
  }

  file { '/usr/local/bin/p4d':
    mode => '0755',
    owner => $user,
    group => $user,
    require => [ Exec['p4d'], User['perforce'] ]
  }

  file { $p4root:
    ensure => directory,
    owner => $user,
    group => $user,
  }

  file { $p4journal:
    ensure => present,
    owner => $user,
    group => $user,
  }

  file { $p4err:
    ensure => present,
    owner => $user,
    group => $user,
  }

  file { '/etc/init/p4d.conf':
    ensure => present,
    content => template("perforce/p4d.conf.erb")
  }

  service { 'p4d':
    ensure => running,
    provider => upstart,
    require => File['/etc/init/p4d.conf']
  }
}

class perforce::client() {
  exec { 'p4':
    command => 'wget http://www.perforce.com/downloads/perforce/r15.1/bin.linux26x86_64/p4',
    path => '/usr/local/bin:/usr/bin:/bin',
    cwd => '/usr/local/bin',
    creates => '/usr/local/bin/p4',
  }

  file { '/usr/local/bin/p4':
    mode => '0755',
    require => Exec['p4']
  }
}
