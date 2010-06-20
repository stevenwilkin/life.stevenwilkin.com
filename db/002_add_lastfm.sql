DROP TABLE IF EXISTS lastfm;

CREATE TABLE lastfm (
	guid TEXT PRIMARY KEY,
	title TEXT,
	url TEXT,
	date DATETIME
);
