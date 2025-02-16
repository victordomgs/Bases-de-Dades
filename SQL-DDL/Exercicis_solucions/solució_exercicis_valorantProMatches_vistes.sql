/*******************************************************************************
   Utilitzant la base de dades valorantProMatches, realitzeu els següents exercicis sobre vistes:
********************************************************************************/

/*Crea una vista anomenada player_basic_stats que mostri el player_id, el game_id, els kills, les deaths i els assists de la taula Player_Stats.*/
CREATE VIEW player_basic_stats AS
SELECT player_id, game_id, kills, deaths, assists
FROM Player_Stats;

/*Crea una vista anomenada games_winners que mostri el game_id, el winner i el nom de l’equip guanyador (de la taula Teams).*/
CREATE VIEW games_winners AS
SELECT g.game_id, g.winner, t.name AS winner_team
FROM Games g
JOIN Teams t ON g.winner = t.team_id;

/*Crea una vista anomenada games_high_rounds que mostri el game_id, team1_id, team2_id, team1_TotalRounds i team2_TotalRounds de les partides on algun dels dos equips ha guanyat més de 13 rondes.*/
CREATE VIEW games_high_rounds AS
SELECT game_id, team1_id, team2_id, team1_TotalRounds, team2_TotalRounds
FROM Games
WHERE team1_TotalRounds > 13 OR team2_TotalRounds > 13;

/*Crea una vista anomenada games_overtime que mostri el game_id, team1_id, team2_id, Team1_RoundsOT i Team2_RoundsOT de les partides on s’ha jugat pròrroga (és a dir, alguna de les dues columnes de RoundsOT és més gran que 0).*/
CREATE VIEW games_overtime AS
SELECT game_id, team1_id, team2_id, Team1_RoundsOT, Team2_RoundsOT
FROM Games
WHERE Team1_RoundsOT > 0 OR Team2_RoundsOT > 0;

/*Crea una vista anomenada top_performers que mostri el player_id, game_id, acs, kills i deaths dels jugadors que tinguin un acs superior a 250.*/
CREATE VIEW top_performers AS
SELECT player_id, game_id, acs, kills, deaths
FROM Player_Stats
WHERE acs > 250;
