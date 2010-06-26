# life.stevenwilkin.com

a simple lifestream app listing some of my online activities:

* blog posts
* delicious bookmarks
* lastfm loved tracks 

the front end is a simple [sinatra](http://www.sinatrarb.com/) app accessing a
sqlite database which in turn is updated via ruby scripts launched by cron jobs


## install dependencies

	gem install sinatra haml sqlite3


## clone repo

	git clone git://github.com/stevenwilkin/life.stevenwilkin.com.git


## create and populate database

	cd life.stevenwilkin.com
	./bin/create_database.rb
	./bin/update_blog.rb
	./bin/update_delicious.rb
	./bin/update_lastfm.rb


## optionally setup cron jobs

the following cron entries will kick off the database update scripts at 00:20,
00:25 and 00:30 nightly:

	20 0 * * * /var/www/life.stevenwilkin.com/bin/update_blog.rb 1>/dev/null
	25 0 * * * /var/www/life.stevenwilkin.com/bin/update_delicious.rb 1>/dev/null
	30 0 * * * /var/www/life.stevenwilkin.com/bin/update_lastfm.rb 1>/dev/null

## run server and enjoy

	rackup ./config.ru

browse to [http://0.0.0.0:9292](http://0.0.0.0:9292)


2010 Steven Wilkin | [@stevebiscuit](http://twitter.com/stevebiscuit) | [stevenwilkin.com](http://stevenwilkin.com)
