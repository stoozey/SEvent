///@desc Creates an event and add it to the global events
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

function sevent_global_destroy(_name)
{
	var _event = sevent_global_get(_name, false);
	if (_event == undefined) return;
	
	delete _event;
}

function sevent_global_get(_name, _processFlag = true)
{
	var _event = global.__sevent_events[$ _name];
	if ((_processFlags) && (_event == undefined) && (SEVENT_CREATE_GLOBAL_IF_DOESNT_EXIST))
		_event = sevent_global_create(_name);
	
	return _event;
}

function sevent_global_connect(_name, _onFire, _flags = SEVENT_CONNECTION_FLAGS.NONE)
{
	var _event = sevent_global_get(_name);
	_event.connect(_onFire, _flags);
}

function sevent_global_fire(_name, _args)
{
	var _event = sevent_global_get(_name);
	_event.fire(_args);
}