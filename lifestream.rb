#!/usr/bin/env ruby

require 'rubygems'
require 'sinatra'
require 'haml'
require 'sass'
require 'faker'

class LifeStream < Sinatra::Base

	set :static, true
	set :public, File.join(File.dirname(__FILE__), 'public')
	set :logging, true

	get '/' do
		@items = []
		1.upto(10).each do
			date = Time.utc(2010, 1 + rand(12), 1+ rand(28), rand(24), rand(50))
			url = 'http://' + Faker::Internet.domain_name() + '/' + Faker::Lorem.words(rand(6)).join('/')
			type = %w(blog lastfm delicious)[rand(3)]
			@items << {:type => type, :date => date, :url => url}
		end
		haml :index
	end

	get '/css/:stylesheet.css' do
		content_type 'text/css', :charset => 'utf-8'
		sass params[:stylesheet].to_sym
	end

end
