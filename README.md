# SEvent
An lightweight and easy to use event system for Gamemaker Studio 2.3+

GML often encourages coding styles where objects and scripts all reference eachother directly which creates a ton of problems that over time can become _impossible_ to fix.
Events are great for abstracting code from eachother and keeping everything tidy. (It's also pretty useful for networking!)

---

All you need to do in order to use the system is connect a function to an event and then fire it, everything else is handled automatically.

The system works by attaching "connections" that contain a function to event objects. These connections can be manipulated with functions such as `connect()`, `disconnect()`, `destroy()`, etc.
Multiple connections can be connected to a single event.

## Usage Examples
[These examples are taken from the working demo that is included in the project.](https://github.com/stoozey/SEvent/tree/main/objects/obj_sevent_demo)

#### Global Events
Global events are the most convenient way of using SEvent. Global events are represented by strings.
	//// (in the create event)
	// Create the event (this can be automated via use of scr_sevent_config)
	sevent_global_create("mb_left_pressed");
	
	// create a connection to the event
	sevent_global_connect("mb_left_pressed", function() {
		show_debug_message("mb_left was pressed");
	});

	//// (in the step event)
	if (mouse_check_button_pressed(mb_left))
		sevent_global_fire("mb_left_pressed");
#### Firing an event:
	(player instance)
	if (keyboard_check_pressed(vk_space))
	{
		jump();
		sevent_fire("player_jumped");
	}
## Event Categories Example
For extra organization, you can have separate categories for your events. Using the previous example, we could instead use an extra argument like so:
#### Connecting to an event:
	(some random instance)
	sevent_connect("jumped", OnPlayerJumped, "player");

#### Firing an event:
	(player instance)
	sevent_fire("jumped", "player"); // Fires the connected event
	sevent_fire("jumped", "enemy"); // Nothing will happen! Incredible!
Now we can have lots of "jumped" events tied to different instances that use completely separate categories.
## Disconnecting Events
What if I don't want the event to run anymore? Two options.
 1. `sevent_connect()` has an optional argument `fireOnce`, the event will disconnect itself upon being called.
 3. `sevent_connect()` returns an `SEventConnection` which has a function named `disconnect()` that you can call. Changed your mind, want it connected again? `connect()`.
