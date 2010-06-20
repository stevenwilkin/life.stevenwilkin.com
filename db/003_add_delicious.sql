DROP TABLE IF EXISTS delicious;

CREATE TABLE delicious (
	guid TEXT PRIMARY KEY,
	title TEXT,
	url TEXT,
	date DATETIME
);
