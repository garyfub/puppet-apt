# apt.pp

class apt {
	$root = '/etc/apt'
	$provider = '/usr/bin/apt-get'

        if ($::lsbdistcodename == "lucid") {
		package { "python-software-properties": }
        }

	file { "sources.list":
		name => "${root}/sources.list",
		ensure => present,
		content => '# MANAGED BY PUPPET - use apt::source instead',
		owner => root,
		group => root,
		mode => 644,
	}

	file { "sources.list.d":
		name => "${root}/sources.list.d",
		ensure => directory,
		owner => root,
		group => root,
	}

	exec { "apt_update":
		command => "${provider} update",
		subscribe => [ File["sources.list"], File["sources.list.d"] ],
		refreshonly => true,
	}
}
