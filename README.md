lazy-puppy
==========

barebones manifest for spinning up a general-purpose CentOS webapp node with 'puppet apply'.  This approach is not fancy.  This is by design.

Usage: puppet apply base.pp

You will need to have the puppet RPM source in place to work with their packages.  An example file lives in 'manifests/modules/repos/files/puppetlabs.repo' to be copied to '/etc/yum.repos.d/puppetlabs.repo'


Note that some VPS providers only push out a kernel without the module tree; attempts to apply iptables might yield errors similar to: 

	'x86_64/modules.dep: No such file or directory'

n.b. that without modification, $(puppet apply base.pp) will change your default SSHd port to 212.  This is to reduce bot traffic on your logs.

