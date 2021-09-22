moveAmount = 32;

xTo = 0;
yTo = 0;
jump = function() { };

Test1 = function() { show_debug_message("1"); };
Test2 = function() { show_debug_message("2"); };
Test3 = function() { show_debug_message("3"); };
Test4 = function() { show_debug_message("4"); };

sevent_connect("player_jumped", Test1);
sevent_connect("player_jumped", Test2, _SEVENT_CATEGORY_DEFAULT, true);
sevent_connect("player_jumped", Test3);
sevent_connect("player_jumped", Test4);

move = function(_xTo, _yTo)
{
	xTo += _xTo;
	yTo += _yTo;
	
	disconnect();
}

moveConnections = [
	new SEventConnection("move_left", function() { move(-moveAmount, 0); }),
	new SEventConnection("move_right", function() { move(moveAmount, 0); }),
	new SEventConnection("move_up", function() { move(0, -moveAmount); }),
	new SEventConnection("move_down", function() { move(0, moveAmount); }),
];

disconnect = function()
{
	var _totalConnections = array_length(moveConnections);
	for (var i = 0; i < _totalConnections; i++)
	{
		var _connection = moveConnections[i];
		_connection.disconnect();
	}
}

reconnect = function()
{
	var _totalConnections = array_length(moveConnections);
	for (var i = 0; i < _totalConnections; i++)
	{
		var _connection = moveConnections[i];
		_connection.connect();
	}
}