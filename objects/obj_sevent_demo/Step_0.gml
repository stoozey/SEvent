// globals
if (mouse_check_button_pressed(mb_left))
	sevent_global_fire("mb_left_pressed");

// fire once flag
if (keyboard_check_pressed(vk_anykey))
	fireOnceEvent.fire([keyboard_lastkey]);