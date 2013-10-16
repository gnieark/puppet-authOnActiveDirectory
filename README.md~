puppet-authOnActiveDirectory
============================
/!\ Actual Version is buggy, i am working on
============================

Ce module puppet permet de configurer les ordinateurs afin que l'identification des utilisateurs 
se fasse en utilisant les comptes Active Directory d'un contrôleur de domaine.

* Configure krb et samba pour intégrer l'ordinateur au domaine active directory
* Configure pam pour que l'authentification se fasse sur les comptes windows (via winbind)

C'est une version CHARLIE (pire que beta). Testé sur uin controleur de domaine windows 2012 serveur 
avec le mode de comptabiltié NT4 activé (regardez du coté des GPO pour faire ça). Les clients utilisés pour
les tests étaient des Debian 7

L'automontage des partages fonctionne pour debian XFCE, il y a quelques fichiers à adapter pour gnome et kde (plus tard)

===
This puppet module configures computers as it: User auth is based on a Microsoft active Directory
* Install and configure krb5 for joining Microsoft Domain controler
* Configure pam for auth by winbind

That's a "charlie" version (worst than beta). It was tested on an active directory Windows server 2012, 
configured with NT4 compatibility.  client computer for the test was a Debian 7.

Automount shares only works on debian XFCE. need to verify some points for gnome and KDE 

===

Envoyez le contenu du git dans le dossier PuppetDirectory/modules/authonad

/etc/puppet/manifests/modules.pp
   import["authonad"]
 



Exemple d'utilisation dans le fichier /etc/puppet/manifests/site.pp 

    node default {
        class { 'authonad':
          winbindacct    => 'administrateur',
          winbindpass    => 'OurBigPassword',
          nomnetbios       => 'DOM.BOISPETIT',
          workgroup     => 'DOMBOISPETIT',  
          suffixedns      => 'dom.boispetit',
          srvad          => 'srv-general',
	  shares => [{host => 'srv-general.dom.boispetit', path => 'intranet', mountpoint => '/media/intranet' },
		     {host => 'srv-general.dom.boispetit', path => 'dosperso/%(USER)', mountpoint => '/media/dossierPersonnel'}
		     ]
	}
        }
        include authonad
    }

Les contributeurs sont les bienvenus!

## To do:
* automount pour gnome et kde
* tests et corrections
* le code est pour des clients debian, l'adapter pour les autres
* Gestion des erreurs lors de l'integration au domaine du "net ads join"


==============================
I'll translate it in english later but contrubutors can traduce the previous text. thanks

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
