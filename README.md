# SIGMA
## Sistema de Ingresos y Gestion Municipal Aplicada

[![Build Status](https://semaphoreci.com/api/v1/projects/909a90e9-7028-4b90-8bd0-b29a8a55c51a/2467762/badge.svg)](https://semaphoreci.com/silmar/sigma)


### Requirements

* Ruby version 2.5.3
* Ruby on Rails version 5.2.1.1
* Database postgresql


### Clone this repository

```
git clone https://JuanVqz@bitbucket.org/oaxteam/sigma.git
cd sigma
bundle install
rails db:create
rails db:migrate
rails db:seed
rails serve
```


### How to run the test suite

```
rake
```


### Deployment instructions

```
cap production deploy
cap production deploy:restart
```
