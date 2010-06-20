#!/usr/bin/env ruby

require 'rubygems'
require 'open-uri'
require 'nokogiri'
require 'parsedate'
require 'sqlite3'

class RssToSQLite

	@@feed = nil
	@@table = nil

	SQL = <<-END_SQL
		INSERT OR IGNORE INTO
			%s
			(guid, title, url, date)
		VALUES
			(?, ?, ?, ?)
	END_SQL
	

	# open db and fetch feed
	def self.init
		@@db = SQLite3::Database.new(File.expand_path(File.join(
			File.dirname(__FILE__), '..', 'db', 'lifestream.db')))
		puts 'Fetching feed'
		@@doc = Nokogiri::XML(open(@@feed))
	end
	

	# process each item in feed and upsert into sqlite
	def self.process
		@@doc.xpath('//item').each do |item|
			title = item.at_css('title').content
			date = item.at_css('pubDate').content
			date = Time.utc(*ParseDate.parsedate(date)).to_i	# timestamp in milliseconds
			url = item.at_css('link').content
			guid = item.at_css('guid').content
			puts "Adding: #{title}"
			@@db.execute(SQL % @@table, guid, title, url, date)
		end
		puts 'Done'
	end

end
