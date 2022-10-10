randomize();

event = new Event();

event.connect(function(_args) {
	show_debug_message("hiii jojo" + string(_args[0]));
});

event.connect(function(_args) {
	show_debug_message("byeeee jojo" + string(_args[0]));
}, SEVENT_CONNECTION_FLAGS.FIRE_ONCE);


alarm[0] = 60;