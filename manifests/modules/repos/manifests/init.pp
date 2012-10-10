class addrepos { 
	#yeah....this isn't v. helpful
	file { '/etc/yum.repos.d/puppetlabs.repo':
		owner		=> root,
		group		=> root,
		mode		=> '0644',
		source	=> '/opt/puppet/manifests/modules/repos/files/puppetlabs.repo',
	}
}
