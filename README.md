
# SEvent
_A simple event system for GameMaker_

You can also find this hosted on my [Itch.io page](https://stoozey.itch.io/sevent).

GML often encourages coding styles where objects and scripts all reference eachother directly which creates a ton of problems that over time can become _impossible_ to fix.
Events are great for abstracting code from eachother and keeping everything tidy. (It's also pretty useful for networking!)

---

All you need to do in order to use the system is connect a function to an event and then fire it, everything else is handled automatically.

The system works by attaching "connections" that contain a function to event objects. These connections can then be manipulated with `reconnect()`, `disconnect()`, `destroy()`, etc. 

Multiple connections can be connected to a single event.

## Usage Examples
[The project includes a demo which you can look at for a better understanding of SEvent in action.](https://github.com/stoozey/SEvent/tree/main/objects/obj_sevent_demo)

### Arguments
The first argument given to a connected function is the connection itself (as these functions are called from the context where they were created, not from the connection itself). You can also pass a second, optional, argument--if you want multiple arguments, simply make it an array.

### Global Events
Global events are the most convenient way of using SEvent. Global events are represented by strings.
#####  Initialization
```
clickedCount = 0;

// Create the event (this can be automated in scr_sevent_config)
sevent_global_create("mb_left_pressed");

// Create a connection to the event
sevent_global_connect("mb_left_pressed", function(_connection) {
	show_debug_message("mb_left was pressed " + string(clickedCount) + " times!");
	clickedCount++;
});
```
##### Firing
```
// Fire the event
if (mouse_check_button_pressed(mb_left))
	sevent_global_fire("mb_left_pressed");
```
---
### Local Events
If you want to store events in your own way separate from globals, you can.
##### Initialization
```
event = new Event();
counter = 0;

event.connect(function(_connection, _increment) {
	counter += _increment;
	show_debug_message("new counter value is " + string(counter));
});
```
##### Firing
```
if (mouse_check_button_pressed(mb_left))
{
	var _increment = irandom(69);
	event.fire(_increment);
}
```
---
### Disconnecting/Destroying Connections
Whenever you connect to an event, it returns the Connection object which can be manipulated.
It's important to know the difference between disconnect() and destroy() to avoid memory leaks!

#### `connection.disconnect()`
Stops the connection from being called when the event fires.

#### `connection.reconnect()`
Allows the function to be called again when the event fires.

#### `connection.destroy()`
Disconnects the connection and queues it to be destroyed.
Make sure you call this if you want your connection PERMANENTLY removed instead of just disconnect! 

---
### Flags
Flags are optional values that can be added to a connection. Currently, only one exists: `SEVENT_CONNECTION_FLAGS.FIRE_ONCE` which as you can guess, will destroy the connection after it fires.
```
fireOnceEvent.connect(function(_connection, _args) {
	// blah
}, SEVENT_CONNECTION_FLAGS.FIRE_ONCE);
```
