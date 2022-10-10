randomize();

event = new Event();

event.connect(function(_args) {
	show_debug_message("hiii " + string(_args));
});

event.connect(function(_args) {
	show_debug_message("byeeee" + string(_args));
}, SEVENT_CONNECTION_FLAGS.FIRE_ONCE);


alarm[0] = 60;