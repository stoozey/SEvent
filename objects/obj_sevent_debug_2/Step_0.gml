if (keyboard_check_pressed(vk_space))
{
	jump();
	
	sevent_fire("player_jumped");
	connection.disconnect();
}

