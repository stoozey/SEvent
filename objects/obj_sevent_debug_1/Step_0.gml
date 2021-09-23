if (keyboard_check_pressed(vk_space))
{
	jump();
	sevent_fire("player_jumped");
}

var _xAxis = ((keyboard_check_pressed(vk_right) - keyboard_check_pressed(vk_left)));
var _yAxis = ((keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up)));

var _amount = irandom(80);
switch (_xAxis)
{
	case 1: sevent_fire("move_right", _amount); break;
	case -1: sevent_fire("move_left", _amount); break;
}

switch (_yAxis)
{
	case 1: sevent_fire("move_down", _amount); break;
	case -1: sevent_fire("move_up", _amount); break;
}

if (xTo != 0)
{
	var _xTo = sign(xTo);
	x += _xTo;
	xTo -= _xTo;
	
	if ((xTo == 0) && (yTo == 0))
		reconnect();
}

if (yTo != 0)
{
	var _yTo = sign(yTo);
	y += _yTo;
	yTo -= _yTo;
	
	if ((xTo == 0) && (yTo == 0))
		reconnect();
}