class iptables { 
	package { 'iptables':
		ensure	=> present,
		notify	=> Service['iptables'];
	}
	
	file { '/etc/sysconfig/iptables':
		owner	=> 'root',
		group	=> 'root',
		mode	=> 0600,
		source	=> '/opt/puppet/manifests/modules/iptables/files/iptables';
	}
	service { 'iptables':
		ensure		=> running,
		enable		=> true,
		hasstatus	=> true,
		subscribe	=> File['/etc/sysconfig/iptables'],
		require		=> File['/etc/sysconfig/iptables'];
	}
}
#inherit classes if needed
