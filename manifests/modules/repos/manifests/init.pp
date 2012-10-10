#should be parameter-ized for maximum DRYness

#class addrepos( $fileName, $fileSource){
#	file { "/etc/yum/repos.d/$fileName":
#		owner	=> root,
#		group	=> root,
#		mode	=> '0644',
#		source	=> "$fileSource",
#	}
#}

class addrepos { 
	#yeah....this isn't v. helpful
	file { '/etc/yum.repos.d/puppetlabs.repo':
		owner	=> root,
		group	=> root,
		mode	=> '0644',
		source	=> '/opt/puppet/manifests/modules/repos/files/puppetlabs.repo',
	}
	file { '/etc/yum.repos.d/nginx.repo':
		owner	=> root,
		group	=> root,
		mode	=> '0644',
		source	=> '/opt/puppet/manifests/modules/repos/files/nginx.repo',
	}
}


