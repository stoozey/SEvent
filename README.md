# SEvent
An easy to use event system for Gamemaker Studio 2.3+

GML often encourages coding styles where objects and scripts all reference eachother directly which creates a ton of problems that over time can become _impossible_ to fix.
Events are great for abstracting code from eachother and keeping everything tidy. (It's also pretty useful for networking!)


## Basic Example
All you need to do in order to use the system is connect a function to an event and then fire it, everything else is handled automatically.
#### Connecting to an event:
	(some random instance)
	OnPlayerJumped = function() { jumpCounter++; };
	sevent_connect("player_jumped", OnPlayerJumped);

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
