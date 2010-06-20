#!/usr/bin/env ruby

require File.expand_path(File.join(
	File.dirname(__FILE__), '..', 'lib', 'rss_to_sqlite'))

class Blog < RssToSQLite
	@@feed = 'http://sickbiscuit.com/blog/feed/'
	@@table = 'blog'
end

Blog.init
Blog.process
