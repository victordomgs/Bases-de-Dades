/*******************************************************************************
   Utilitzant la base de dades valorantProMatches, realitzeu els següents exercicis sobre consultes:
********************************************************************************/


/*Mostra el nom de l'equip que més victòries té? Taules: 'teams' i 'games'*/

SELECT t.name AS team_name
FROM teams t
WHERE t.name = (
    SELECT winner
    FROM (
        SELECT winner, COUNT(*) AS wins
        FROM games
        GROUP BY winner
        ORDER BY wins DESC
        LIMIT 1
    ) sub
);

/*Quin és el jugador amb més eliminacions (kills) en una única partida? Indica el nom del jugador (com a player_name). Taules: player_stats, players*/

SELECT p.name AS player_name
FROM players p
WHERE p.player_id = (
    SELECT ps.player_id
    FROM player_stats ps
    GROUP BY 1
    ORDER BY MAX(kills) DESC
    LIMIT 1
);

/*Quin és el nom de l'agent més utilitzat a tots els partits? Taules: agets, player_stats*/

SELECT a.name
FROM agents a
WHERE a.agent_id = (
    SELECT agent_id
    FROM player_stats
    GROUP BY agent_id
    ORDER BY COUNT(*) DESC
    LIMIT 1
);

/*Quins són els distints equips que han jugat al mapa més popular? Taules: games, maps, teams*/

SELECT DISTINCT t.name
FROM teams t
JOIN games g ON t.team_id = g.team1_id OR t.team_id = g.team2_id
WHERE g.map_id = (
    SELECT map_id
    FROM games
    GROUP BY map_id
    ORDER BY COUNT(*) DESC
    LIMIT 1
);

/*Quins és l'esdeveniment (eventName) que ha tingut més partits? Taules: events, matches*/

SELECT DISTINCT e.eventName AS event_name
FROM events e
JOIN matches m ON e.event_id = m.event_id
WHERE e.event_id = (
    SELECT event_id
    FROM matches
    GROUP BY event_id
    ORDER BY COUNT(*) DESC
    LIMIT 1
);
