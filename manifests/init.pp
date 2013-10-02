class authonad($winbindacct, $winbindpass, $nomnetbios,$workgroup,$suffixedns, $srvad){
	package{
	  'krb5-user': ensure => installed;
	  'winbind':   ensure => installed;
	  'expect':    ensure => installed;
	  'samba':     ensure => installed;
	}
	service { "samba":
		    ensure  => "running",
		    enable  => "true",
		    require => Package["samba"],
	}
	service { "winbind":
		    ensure  => "running",
		    enable  => "true",
		    require => Package["winbind"],
	}
        file
        { "/etc/samba/smb.conf":
                path    => "/etc/samba/smb.conf",
                owner   => root,
                group   => root,
                mode    => 644,
                content => template("authonad/smb-conf.erb"),
                notify  => service["samba","winbind"]

        }
       	file
        { "/etc/krb5.conf ":
                path    => "/etc/krb5.conf",
                owner   => root,
                group   => root,
                mode    => 644,
                content => template("authonad/krb5-conf.erb")
        }
             
	file
        { "/etc/nsswitch.conf":
                path    => "/etc/nsswitch.conf",
                owner   => root,
                group   => root,
                mode    => 644,
                content => template("authonad/nsswitch-conf.erb")
        }

        file
        { "/etc/pam.d/common-auth":
                path    => "/etc/pam.d/common-auth",
                owner   => root,
                group   => root,
                mode    => 644,
                content => template("authonad/common-auth.erb")
        }

        file
        { "/etc/pam.d/common-session":
                path    => "/etc/pam.d/common-session",
                owner   => root,
                group   => root,
                mode    => 644,
                content => template("authonad/common-session.erb")
        }
        file
        { "/etc/pam.d/common-account":
                path    => "/etc/pam.d/common-account",
                owner   => root,
                group   => root,
                mode    => 644,
                content => template("authonad/common-account.erb")
        }
        file
        { "/etc/pam.d/common-passwd":
                path    => "/etc/pam.d/common-passwd",
                owner   => root,
                group   => root,
                mode    => 644,
                content => template("authonad/common-passwd.erb")
        }
	file { '/home':
    		ensure  => directory,
    		owner   => 'root',
    		group   => 'root',
    		mode    => '0755',
  	}
        $homedirectory = "/home/${nomnetbios}"
        file {$homedirectory :
	  ensure => "directory",
	  owner   => root,
          group   => root,
	  mode    => 0755
	}
	$lacommande= "net join ads -U ${winbindacct}%${winbindpass} -S ${srvad}.${suffixedns}"
	
	exec{"cmd1":
	  command	=> $lacommande,  
	  require	=> [ File["/etc/samba/smb.conf"], File["/etc/krb5.conf"], File["/etc/nsswitch.conf"], File["/etc/pam.d/common-auth"],
	    File["/etc/pam.d/common-session"], File["/etc/pam.d/common-account"],  File["/etc/pam.d/common-passwd"], Package["winbind"], Package["samba"]
	  ],
	  path    => ["/usr/bin", "/usr/sbin"]
	}
	exec{"cmd2":
	      command => "wbinfo -u",
	      path    => ["/usr/bin", "/usr/sbin"],
              require	=> [Package["winbind"], Package["samba"]]
	    #  require	=> Exec["cmd1"]
	 }
	exec{"cmd3":
	      command => "wbinfo -g",
	      path    => ["/usr/bin", "/usr/sbin"],
	     require   => [Package["winbind"], Package["samba"]],
	      notify  => service["samba","winbind"]
	 }
}
