define sudo::ruleset(
  $sudo_rule_list = undef,
	$sudo_defaults_list = undef
) 
{
  if $sudo_rule_list == undef and $sudo_defaults_list == undef {
    warning("No sudoers are defined")
  }

  file { "/etc/sudoers.d/${name}":
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0440', 
    content => template('sudo/rulelist.erb'),
    require => Class['sudo'],
  } 
}
