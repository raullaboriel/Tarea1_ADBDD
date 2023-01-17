/* JOSE RAUL LABORIEL TORRES - 62018000 */

create table teams (
		team_id integer not null,
		team_name varchar(30) not null,
		unique(team_id)
);

create table matches (
		match_id integer not null,
		host_team integer not null,
		guest_team integer not null,
		host_goals integer not null,
		guest_goals integer not null,
		unique(match_id)
);

INSERT INTO teams VALUES
(10, 'Give'),
(20, 'Never'),
(30, 'You'),
(40, 'Up'),
(50, 'Gonna')


INSERT INTO matches VALUES 
(1, 30, 20, 1, 0),
(2, 10, 20, 1, 2),
(3, 20, 50, 2, 2),
(4, 10, 30, 1, 0),
(5, 30, 50, 0, 1)

SELECT Teams.team_id, 
Teams.team_name,
    ifnull(sum(CASE WHEN Teams.team_id = Matches.host_team AND Matches.host_goals > Matches.guest_goals THEN 3
    WHEN Teams.team_id = Matches.host_team AND Matches.host_goals = Matches.guest_goals THEN 1
    WHEN Teams.team_id = Matches.guest_team AND Matches.host_goals < Matches.guest_goals THEN 3
    WHEN Teams.team_id = Matches.guest_team AND Matches.host_goals = Matches.guest_goals THEN 1
    ELSE 0 END), 0) as num_points
FROM Matches 
RIGHT JOIN Teams
ON Matches.host_team = Teams.team_id OR Matches.guest_team = Teams.team_id
GROUP BY team_id, team_name
ORDER BY num_points DESC, team_id