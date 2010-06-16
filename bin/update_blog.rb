#!/usr/bin/env ruby

require 'rubygems'
require 'open-uri'
require 'nokogiri'
require 'parsedate'
require 'sqlite3'

SQL = <<END_SQL
	INSERT OR IGNORE INTO
		blog
		(guid, title, link, date)
	VALUES
		(?, ?, ?, ?)
END_SQL

db = SQLite3::Database.new(File.expand_path(File.join(File.dirname(__FILE__), '..', 'db', 'lifestream.db')))

puts 'Fetching feed'

FEED = 'http://sickbiscuit.com/blog/feed/'
doc = Nokogiri::XML(open(FEED))

doc.xpath('//item').each do |item|
	title = item.at_css('title').content
	date = item.at_css('pubDate').content
	date = Time.utc(*ParseDate.parsedate(date)).to_i	# timestamp in milliseconds
	link = item.at_css('link').content
	guid = item.at_css('guid').content
	puts "Adding: #{title}"
	rows = db.execute(SQL, guid, title, link, date)
end

puts 'Done'
