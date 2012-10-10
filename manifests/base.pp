#Need to put the puppetlabs repos
import 'modules/*/*/*'

#packages - not that simply ensure=>installed won't satisfy circular dependencies 
#if unsure of package name, yum search.  puppet resource package package_name to view
$base_utils = [ "sudo", "nc", "tcpdump", "strace", "passwd", "ntp", "gcc" ]
$base_packages 	= [ "git", "vim-enhanced", "zsh" ]
$base_web = [ "python", "php", "php-mysql", "mysql", "mysql-server" ]

package { $base_utils: ensure => installed }
package { $base_packages: ensure => installed } 
package { $base_web: ensure => installed } 

#sets SSHd port to 212 and 'PermitRootLogin no'
include sshc
include addrepos
include iptables

#Enter your primary user here:
$myUser = '__ENTER__YOUR__USER__HERE__'
#Enter a host_alias here to deal with potential VPS DNS 'weirdness':
$myHostAlias = '__ENTER_HOST_ALIAS__HERE__'

#tmux lives here http://pkgs.repoforge.org/tmux/

#Now install python stuff via pip
host { 'self':
	ensure		=> present,
	name		=> $fqdn,
	host_aliases	=> [$myHostAlias, $hostname],
	ip		=> $ipaddress,
}

file { 'motd':
	ensure		=> file,
	path		=> '/etc/motd',
	mode		=> 0644,
	content		=> "${domain} :: ${hostname} : ${operatingsystem} \n",
}

#users/groups 

group { 'dev':
	ensure	=> present,
}
group { "$myUser":
	ensure	=> present,
}

user { "${myUser}":
	ensure		=> present,
	groups 		=> ['dev', $myUser],
	shell		=> '/bin/zsh',
	home		=> "/home/$myUser",
	managehome	=> true,
}


#mount /tmp as "noexec" to eliminate write & run exploits

#find files that are o+wr :
# find / -wholename '/proc' -prune -o ! -type l -perm -o+wx -exec ls -ld {} \;
# "-wholename '/proc' to avoid printing errors as find traverses /proc and discovers
# its PID's corpse 
