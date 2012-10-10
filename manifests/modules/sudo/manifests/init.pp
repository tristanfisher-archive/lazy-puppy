class sudo {
  package { 'sudo':
    ensure => present,
  }

  file { '/etc/sudoers':
    owner   => 'root',
    group   => 'root',
    mode    => 440,
    content => template('sudo/sudoers.erb'),
    require => Package['sudo'],
  }

  file { '/etc/sudoers.d':
    ensure => directory,
    mode   => 750,
  }

}
