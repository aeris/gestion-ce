# Gestion CE

Cette application est conçue pour gérer le budget d'un CE réparti suivant plusieurs agences, avec une répartition des
budgets suivant les effectifs de chaque agence.

Elle est développée avec [Ruby on Rails](http://rubyonrails.org/) (v4.0) et utilise [Bootstrap](http://getbootstrap.com/2.3.2/)
(v2.3.2) pour l'aspect graphique.<br/>
Elle est libérée sous licence [AGPLv3 ou ultérieur](https://www.gnu.org/licenses/agpl-3.0.html).

Les icônes utilisées ont été créées par [Mark James](http://www.famfamfam.com/lab/icons/silk/) et sont sous
[licence CC BY 3.0](https://creativecommons.org/licenses/by/3.0/).

## Utilisation

Une démonstration est disponible [ici](https://demo.imirhil.fr/gestion-ce/) (Login `admin // admin`).

## Installation

### Dépendances

Pour une utilisation en développement, vous pouvez installer les dépendances via `bundle install`.<br/>
Pour une utilisation en production, préférez `bundle install --without test development --deployment`.<br/>
(NB : pour repasser en mode développement après un déploiment, `bundle install --without '' --no-deployment`)

Il est nécessaire d'avoir le kit de développement de la base de données utilisée pour pouvoir installer les dépendances
associées.

1. Pour SQLite, `apt-get install libsqlite3-dev`
2. Pour PostgreSQL, `apt-get install libpq-dev`
2. Pour MySQL, `apt-get install libmysqlclient-dev`

### Précompilation du Javascript et du CSS

En production, il est conseillé de précompiler le JS et le CSS (voir [Asset Pipeline](http://guides.rubyonrails.org/asset_pipeline.html)
de la documentation Ruby on Rails.<br/>
Ceci peut être réalisé avec la commande `RAILS_ENV=production rake assets:precompile`

### Base de données

L'application nécessite une base de données pour fonctionner.<br/>
Tous les moteurs de bases de données supportés par [Active Record](http://guides.rubyonrails.org/active_record_basics.html)
devraient être utilisables.<br/>
Seuls [SQLite](https://www.sqlite.org/) et [PostgreSQL](http://www.postgresql.org/) ont cependant été utilisés durant le
développement.<br/>
Il est recommandé de ne pas utiliser SQLite en production.

1. Créer la base de données souhaitée ainsi que l'utilisateur si nécessaire
2. Éditer le fichier config/database.yml et renseigner les paramètres de connexion
3. Éditer le ficher db/seeds.rb
  1. Éditer le nom de votre première agence
  2. Éditer les données de votre premier utilisateur
  3. Éditer le numéro de vos comptes bancaires
4. Lancer la création et le remplissage de la base avec `RAILS_ENV=production rake db:migrate db:seed`

### Serveur web

En développement, vous pouvez lancer directement le serveur embarqué par Ruby on Rails pour tester votre application.<br/>
Après avoir lancer `rails server`, l'application est accessible via `http://localhost:3000/`.

En production, il est conseillé de servir l'application via votre serveur web habituel.<br/>
Pour [Apache](https://httpd.apache.org/) ou [NGinx](http://nginx.org/), vous pouvez utiliser
[Phusion Passenger](https://www.phusionpassenger.com/).

## Contributions

Les contributions sont les bienvenues sur ce projet.<br/>
N'hésitez pas à [ouvrir un ticket](https://github.com/aeris/gestion-ce/issues) pour remonter un bug ou demander une
nouvelle fonctionnalité.<br/>
Vous pouvez aussi directement [proposer un patch](https://github.com/aeris/gestion-ce/pulls).

N'hésitez pas à me faire un retour si vous utilisez cette application.
