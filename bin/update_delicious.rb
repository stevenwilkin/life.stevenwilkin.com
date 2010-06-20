#!/usr/bin/env ruby

require File.expand_path(File.join(
	File.dirname(__FILE__), '..', 'lib', 'rss_to_sqlite'))

class LastFM < RssToSQLite
	@@feed = 'http://feeds.delicious.com/v2/rss/stevebiscuit?count=15'
	@@table = 'delicious'
end

LastFM.init
LastFM.process
