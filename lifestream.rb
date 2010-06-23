#!/usr/bin/env ruby

require 'rubygems'
require 'sinatra'
require 'haml'
require 'sass'
require 'sqlite3'

SQL = <<END_SQL
	SELECT
		*, 'blog' AS type
	FROM
		blog
	UNION
	SELECT
		*, 'lastfm' AS type
	FROM
		lastfm
	UNION
	SELECT
		*, 'delicious' AS type
	FROM
		delicious
	ORDER BY
		date DESC
	LIMIT ? OFFSET ?
END_SQL

ITEMS_PER_PAGE = 20

SQL_NUM_PAGES =<<END_SQL
	SELECT COUNT(*) FROM
	(
		SELECT * FROM blog UNION
		SELECT * FROM delicious UNION
		SELECT * FROM lastfm
	)
END_SQL

class LifeStream < Sinatra::Base

	set :static, true
	set :public, File.join(File.dirname(__FILE__), 'public')
	set :logging, true

	get '/:page?' do
		db = SQLite3::Database.new(File.expand_path(File.join(
			File.dirname(__FILE__), 'db', 'lifestream.db')))
		db.results_as_hash = true
		total_items = db.execute(SQL_NUM_PAGES)[0][0]
		@pages = (total_items.to_f / ITEMS_PER_PAGE).ceil
		@page = params[:page].to_i
		@page = 1 if @page == 0
		@items = db.execute(SQL, ITEMS_PER_PAGE, (@page - 1) * ITEMS_PER_PAGE)
		haml :index
	end

	get '/css/:stylesheet.css' do
		content_type 'text/css', :charset => 'utf-8'
		sass params[:stylesheet].to_sym
	end

end
