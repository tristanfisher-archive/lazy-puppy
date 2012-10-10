class sshc {

	$servicename = 'sshd'
	$packagename = 'openssh-server'

	package { $packagename:
		ensure	=> installed,
	}

	service { $servicename:
		ensure	=> "running",
		enable	=> "true",
		require	=> Package[$packagename],
	}

	#for some reason, using variables made sshd_config into a dir
	file { '/etc/ssh/sshd_config':
		notify	=> Service[$servicename],
		owner	=> root,
		group	=> root,
		mode	=> '0600',
		require	=> Package[$packagename],
		source	=> '/opt/puppet/manifests/modules/sshc/files/sshd_config',
	}
}
