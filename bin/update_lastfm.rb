#!/usr/bin/env ruby

require File.expand_path(File.join(
	File.dirname(__FILE__), '..', 'lib', 'rss_to_sqlite'))

class LastFM < RssToSQLite
	@@feed = 'http://ws.audioscrobbler.com/2.0/user/ahSyd/lovedtracks.rss'
	@@table = 'lastfm'
end

LastFM.init
LastFM.process
