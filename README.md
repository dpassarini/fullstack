# App stack

This an example of how an application can be built using several technologies and put it all together by Docker.

### Technologies used

This project is built over several technologis:

* [Angular 4] - HTML enhanced for web apps!
* [Ruby on Rails] - One of the most popular framework for webapps
* [MySQL] - Reliable and mature open source database
* [Redis] - Ultra fast and easy-to-use memory key-value database

### Installation

You'll need [Docker](https://www.docker.com/community-edition) and [docker-compose](https://docs.docker.com/compose/) to run it.

After install Docker and docker-compose, clone the project, access its directo
ry and run the following:
```sh
$ docker-compose build
$ docker-compose up
```

The build might take a while to complete.

When the stack is up running, you'll still need to create the database.

From the project root directory, run:

```sh
$ cd apps/account_manager
$ rake db:create db:migrate
```

Now you are good to go!