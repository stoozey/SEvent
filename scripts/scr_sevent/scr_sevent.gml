global.__sevents = { };

function SEventConnection(_eventName, _onEvent, _fireOnce = false, _autoConnect = true) constructor
{
	static connect = function()
	{
		if (connected) return false;
		connected = true;
		
		_sevent_listen(eventName, OnEventFired);
		
		return true;
	}
	
	static disconnect = function()
	{
		if (!connected) return false;
		connected = false;
		
		var _sevent = _sevent_get(eventName);
		ds_list_delete(_sevent, ds_list_find_index(_sevent, OnEventFired));
		
		return true;
	}
	
	connected = false;
	
	eventName = _eventName;
	onEventFunc = method(other, _onEvent);
	
	OnEventFired = ((_fireOnce) ?
		function()
		{
			onEventFunc();
			
			disconnect();
		} : onEventFunc
	);
	
	if (_autoConnect)
		connect();
}	

function sevent_fire(_eventName)
{
	var _sevent = _sevent_get(_eventName);
	for (var i = 0; i < ds_list_size(_sevent); i++)
		_sevent[| i]();
}

#region core

function _sevent_get(_eventName, _createIfNotExists = true)
{
	var _sevent = global.__sevents[$ _eventName];
	if ((_createIfNotExists) && (_sevent == undefined))
		_sevent = _sevent_create(_eventName);
	
	return _sevent;
}

function _sevent_create(_eventName)
{
	var _sevent = ds_list_create();
	global.__sevents[$ _eventName] = _sevent;
		
	return _sevent;
}

function _sevent_destroy(_eventName)
{
	 var _sevent = _sevent_get(_eventName, false);
	 if (_sevent == undefined) return;
	 
	 ds_list_destroy(_sevent);
	 global.__sevents[$ _eventName] = undefined;
}

function _sevent_listen(_eventName, _onEvent)
{
	var _sevent = _sevent_get(_eventName);
	ds_list_add(_sevent, _onEvent);
	
	return true;
}

#endregion