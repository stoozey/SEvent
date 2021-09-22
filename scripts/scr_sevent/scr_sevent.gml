////      SEvent ~ @stoozey_      \\\\

///@arg {string}    eventName
///@arg {function}  OnEventFired
///@arg {string}    [categoryName
///@arg {bool}      fireOnce
///@arg {bool}      autoConnect]
///@returns         SEventConnection
function sevent_connect(_eventName, _onEvent, _categoryName = _SEVENT_CATEGORY_DEFAULT, _fireOnce = false, _autoConnect = true)
{
	return new SEventConnection(_eventName, _onEvent, _categoryName, _fireOnce, _autoConnect);
}

///@arg {string}    eventName
///@arg {string}    [categoryName]
function sevent_fire(_eventName, _categoryName = _SEVENT_CATEGORY_DEFAULT)
{
	var _category = _sevent_get_category(_categoryName);
	_category.fire(_eventName);
}

#region do not look at me dont do it do not look in here dont look at me stop looking at me do not look at me stop dont look at me

#macro _SEVENT_CATEGORY_DEFAULT "global"

global.__sevent_categories = { };

///@arg {string}    eventName
///@arg {function}  OnEventFired
///@arg {string}    [categoryName
///@arg {bool}      fireOnce
///@arg {bool}      autoConnect]
function SEventConnection(_eventName, _onEvent, _categoryName = _SEVENT_CATEGORY_DEFAULT, _fireOnce = false, _autoConnect = true) constructor
{
    ///@desc Connect to the event category
	static connect = function()
	{
		if (connected) return false;
		connected = true;
		
        var _category = _sevent_get_category(categoryName);
        _category.add_connection(eventName, OnEventFired);
		
		return true;
	}
	
	///@desc Disconnect from the event category
	static disconnect = function()
	{
		if (!connected) return false;
		connected = false;
		
		var _category = _sevent_get_category(categoryName);
		var _sevent = _category.get_sevent(eventName);
		var _index = ds_list_find_index(_sevent, OnEventFired);
		if (_index == -1) return false;
		
		ds_list_delete(_sevent, _index);
		return true;
	}
	
	connected = false;
	
	eventName = _eventName;
	categoryName = _categoryName;
	onEventFunc = method(other, _onEvent);
	
	OnEventFired = ((_fireOnce) ?
		function() { onEventFunc();	disconnect(); } : onEventFunc
	);
	
	if (_autoConnect)
		connect();
}

function SEventCategory(_name, _enabled = true) constructor
{
	///@desc Fires all connected events
	///@arg {string}   eventName
	static fire = function(_eventName)
	{
		if (!enabled) return;
		
		var _sevent = get_sevent(_eventName, false);
		if (_sevent == undefined) return;
		
		for (var i = 0; i < ds_list_size(_sevent); i++)
			_sevent[| i]();
	}
	
	///@desc Creates a new SEvent and adds it to the sevents struct
	static create_sevent = function(_eventName)
	{
	    var _sevent = ds_list_create();
    	sevents[$ _eventName] = _sevent;
    		
    	return _sevent;
	}
	
	///@desc Returns an SEvent, if it doesn't exist you can create one with an optional argument
	///@arg {string}    eventName
	///@arg {bool}      [createIfNotExists]
	static get_sevent = function(_eventName, _createIfNotExists = true)
	{
		var _sevent = sevents[$ _eventName];
		if ((_createIfNotExists) && (_sevent == undefined))
			_sevent = create_sevent(_eventName);
		
		return _sevent;
	}
	
	static add_connection = function(_eventName, _onEvent)
	{
		var _sevent = get_sevent(_eventName);
		ds_list_add(_sevent, _onEvent);
	}
	
	///@desc Remove a connected function from an SEvent
	///@arg {string}    eventName
	///@arg {function}  ...
	static remove = function(_eventName)
	{
	    var _sevent = get_sevent(_eventName, false);
	    if (_sevent == undefined) return;
	    
	    for (var i = 1; i < argument_count; i++)
	    {
	        var _index = ds_list_find_index(_sevent, argument[i]);
	        if (_index == -1) continue;
	        
	        ds_list_delete(_sevent, _index);
	    }
	}
	
	///@desc Clear/Destroy all SEvents. Alternatively, if provided with event names, it will clear those instead
	///@arg {bool}      destroy
	///@arg {string}    [eventName
	///@arg {string}    ...]
	static clear = function(_destroy = false)
	{
		switch (argument_count <= 1)
		{
			case true:
			{
				var _eventNames = variable_struct_get_names(sevents);
				var _totalNames = array_length(_eventNames);
				for (var i = 0; i < _totalNames; i++)
				{
				    var _sevent = get_sevent(sevents[$ _eventNames[i]]);
					
					switch(_destroy)
					{
					    case true: ds_list_destroy(_sevent); break;
					    case false: ds_list_clear(_sevent); break;
					}
				}
			} break;
			
			case false:
			{
				for (var i = 1; i < argument_count; i++)
				{
					var _sevent = get_sevent(argument[i], false);
					if (_sevent == undefined) return;
					
					switch(_destroy)
					{
					    case true: ds_list_destroy(_sevent); break;
					    case false: ds_list_clear(_sevent); break;
					}
				}
			} break;
		}
	}
	
	///@desc Clean all data from memory (should ALWAYS be called before deleting this struct)
	static cleanup = function()
	{
		var _eventNames = variable_struct_get_names(sevents);
		var _totalNames = array_length(_eventNames);
		for (var i = 0; i < _totalNames; i++)
			ds_list_destroy(sevents[$ _eventNames[i]]);
		
		delete sevents;
	}
	
	sevents = { };
	
	enabled = _enabled;
}

global.__sevent_categories[$ _SEVENT_CATEGORY_DEFAULT] = new SEventCategory(_SEVENT_CATEGORY_DEFAULT);

// Helper
function _sevent_get_category(_categoryName, _createIfNotExists = true)
{
	var _category = global.__sevent_categories[$ _categoryName];
	if ((_createIfNotExists) && (_category == undefined))
		_category = new SEventCategory(_categoryName);
	
	return _category;
}

function _sevent_destroy(_categoryName, _eventName)
{
    var _category = _sevent_get_category(_categoryName);
    var _sevent = _category.clear(true, _eventName);
}

#endregion