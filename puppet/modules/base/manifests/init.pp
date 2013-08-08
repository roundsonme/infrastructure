class base {

    $source = '/opt/src'
    
    host { 'debian':
        ip => '127.0.0.1',
    }
    
    user { $::username:
        ensure      => present,
        managehome  => true,
        shell       => '/bin/bash',
    }
  
    file { "/home/${::username}/.ssh":
        ensure      => directory,
        owner       => $::username,
        mode        => 0700,
    }
 
    file { "/home/${::username}/.vimrc":
        ensure      => present,
        owner       => $::username,
        source      => 'puppet:///modules/base/vimrc',
    }

    file { "/home/${::username}/.bash_profile":
        ensure      => present,
        owner       => $::username,
        source      => 'puppet:///modules/base/bash_profile',
    }

    file { "/home/${::username}/.gitconfig":
        ensure      => present,
        owner       => $::username,
        source      => 'puppet:///modules/base/gitconfig',
    }

    file { $source:
        ensure      => directory,
        owner       => $::username,
    }

    file { '/etc/mtab':
        ensure      => link,
        target      => '/proc/mounts',
    }
    
    apt::source { 'testing':
        location    => 'http://ftp.uk.debian.org/debian',
        release     => 'testing',
        repos       => 'main contrib non-free',
    }
    
    apt::source { 'unstable':
        location    => 'http://ftp.uk.debian.org/debian',
        release     => 'unstable',
        repos       => 'main contrib non-free',
    }
    
    apt::pin { 'stable':
        priority    => 700,
    }
    
    apt::pin { 'testing':
        priority    => 650,
    }
    
    apt::pin { 'unstable':
        priority    => 600,
    }
    
    file { '/etc/ssh/ssh_known_hosts':
        ensure      => present,
        source      => 'puppet:///modules/base/ssh_known_hosts',
    }

    package { 'vim':
        ensure      => latest,
    }

}
