///@desc Creates an event and add it to the global events
///@param {string} name The name of the event
function sevent_global_create(_name)
{
	var _existingEvent = sevent_global_get(_name, false);
	if (_existingEvent)
	{
		switch (SEVENT_OVERWRITE_GLOBAL_IF_ALREADY_EXISTS)
		{
			case true:
				sevent_global_destroy(_name);
				break;
			
			case false:
				__sevent_print("Global event \"" + _name + "\" already exists; ignoring sevent_global_create");
				return _existingEvent;
		}
	}
	
	var _event = new Event();
	global.__sevent_events[$ _name] = _event;
	
	return _event;
}

///@desc Destoys a global event
///@param {string} name The name of the event
function sevent_global_destroy(_name)
{
	var _event = sevent_global_get(_name, false);
	if (_event == undefined) return;
	
	delete _event;
}

///@desc Retrieves the global event. If SEVENT_CREATE_GLOBAL_IF_DOESNT_EXIST is true, it will create one if it doesn't already exist 
///@param {string} name The name of the event
///@param {bool} [processFlag] Whether or not to process SEVENT_CREATE_GLOBAL_IF_DOESNT_EXIST
function sevent_global_get(_name, _processFlag = true)
{
	var _event = global.__sevent_events[$ _name];
	if ((_processFlag) && (_event == undefined) && (SEVENT_CREATE_GLOBAL_IF_DOESNT_EXIST))
		_event = sevent_global_create(_name);
	
	return _event;
}

///@desc Creates and connects a connection to the global event
///@param {string} name The name of the event
///@param {function} onFire The function to be called upon the event firing
///@param {SEVENT_CONNECTION_FLAGS} [flags] Flags used to alter the way the connection is proccesed
function sevent_global_connect(_name, _onFire, _flags = (SEVENT_CONNECTION_FLAGS.NONE))
{
	var _event = sevent_global_get(_name);
	return _event.connect(_onFire, _flags);
}

///@desc Fires all connected events, and frees any that have been destroyed
///@param {string} name The name of the event
///@param {array} [args] An array of arguments to be passed to the connections on fire function
function sevent_global_fire(_name, _args)
{
	var _event = sevent_global_get(_name);
	_event.fire(_args);
}