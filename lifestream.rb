#!/usr/bin/env ruby

require 'rubygems'
require 'sinatra'
require 'haml'
require 'sass'
require 'sqlite3'

SQL = <<END_SQL
	SELECT
		*
	FROM
		blog
	ORDER BY
		date DESC
END_SQL

class LifeStream < Sinatra::Base

	set :static, true
	set :public, File.join(File.dirname(__FILE__), 'public')
	set :logging, true

	get '/' do
		db = SQLite3::Database.new(File.expand_path(File.join(
			File.dirname(__FILE__), 'db', 'lifestream.db')))
		db.results_as_hash = true
		@items = db.execute(SQL)
		haml :index
	end

	get '/css/:stylesheet.css' do
		content_type 'text/css', :charset => 'utf-8'
		sass params[:stylesheet].to_sym
	end

end
