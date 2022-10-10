//// globals
//   usage of global events instead of local ones
sevent_global_create("mb_left_pressed");

sevent_global_connect("mb_left_pressed", function(_connection) {
	show_debug_message("mb_left was pressed");
});

//// counter
//   an alarm will increase the counter every second
counterEvent = new Event();
counter = 0;

counterEvent.connect(function(_connection) {
	show_debug_message("counterEvent has fired: " + string(++counter) + " times");
});

alarm[0] = room_speed;

//// fire once flag
//   when you press a key, it will print the key then automatically destroy the connection
fireOnceEvent = new Event();

fireOnceEvent.connect(function(_connection, _args) {
	var _key = _args[0];
	show_debug_message("pressed key: " + string(_key));
}, (SEVENT_CONNECTION_FLAGS.FIRE_ONCE));

//// disconnecting/destroying connections
//   it's important to know the difference between disconnect() and destroy() to avoid memory leaks
uselessEvent = new Event();
var _connection = uselessEvent.connect(function() { });

/*
	stops the connection from being called when the event fires.
*/
_connection.disconnect(); 

/*
	allows the function to be called again when the event fires.
*/
_connection.reconnect(); 

/*
	queues the connection to be disconnected *and* destroyed (cleared from memory).
	make sure you call this if you want your connection PERMANENTLY removed instead of just disconnected! 
*/
_connection.destroy(); 