puppet-authOnActiveDirectory
============================

Ce module puppet permet de configurer les ordinateurs afin que l'identification des utilisateurs 
se fasse en utilisant les comptes Active Directory d'un contrôleur de domaine.

C'est une version CHARLIE (pire que beta) Je n'ai pas encore fait tous les tests.

Envoyez le contenu du git dans le dossier PuppetDirectory/modules/authonad

/etc/puppet/manifests/modules.pp
    import ["authonad"]



Exemple d'utilisation dans le fichier /etc/puppet/manifests/site.pp 

    node default {
        class { 'authonad':
          winbindacct    => 'administrateur',
          winbindpass    => 'OurBigPassword',
          nomnetbios       => 'DOMBOISPETIT',
          suffixedns      => 'dom.boispetit',
          srvad          => 'srv-general'
        }
        include authonad
    }

Les contributeurs sont les bienvenus!

==============================
I am a cow when i need to translate in english. Contrubutors can traduce the previous text. thanks

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
