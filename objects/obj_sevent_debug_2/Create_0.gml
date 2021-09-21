jumpCounter = 0;
jump = function() { };

OnPlayerJumped = function() { jumpCounter++; };
connection = sevent_connect("player_jumped", OnPlayerJumped);