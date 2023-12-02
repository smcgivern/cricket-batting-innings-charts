innings.json: innings.sqlite3
	sqlite3 -json innings.sqlite3 'WITH top_sixty AS (SELECT player_id, SUM(runs) FROM men_test_batting_innings WHERE runs IS NOT NULL GROUP BY 1 ORDER BY 2 DESC LIMIT 60) SELECT player, player_id, runs, COUNT(*) OVER (PARTITION BY player_id ORDER BY start_date, innings) AS innings_count FROM men_test_batting_innings WHERE runs IS NOT NULL AND player_id IN (SELECT player_id FROM top_sixty) ORDER BY player, innings_count' > innings.json

preview: innings.json
	@static-server
