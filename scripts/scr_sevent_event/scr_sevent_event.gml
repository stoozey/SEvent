function Event() constructor
{
	///@desc Generates a Connection and connects it to the event
	///@param {function} onFire The function to be called upon the event firing
	///@param {SEVENT_CONNECTION_FLAGS} [flags] Flags used to alter the way the connection is proccesed
	static connect = function(_onFire, _flags = (SEVENT_CONNECTION_FLAGS.NONE))
	{
		var _context = other;
		var _connection = new __sevent_class_connection(_onFire, _flags, _context);
		__connect_connection(_connection);
		
		return _connection;
	}
	
	///@desc Fires all connected events, and frees any that have been destroyed
	///@param {array} [args] An array of arguments to be passed to the connections on fire function
	static fire = function(_args = undefined)
	{
		var i = 0;
		repeat (array_length(__connections))
		{
			var _connection = __get_connection(i++);
			if (_connection == undefined) continue;
			
			_connection.fire(_args);
		}
	}
	
	///@desc Adds a connection to the connection array
	///@param connection The connection to add
	///@ignore
	static __connect_connection = function(_connection)
	{
		__regenerate_connections();
		array_push(__connections, _connection);
	}
	
	///@desc Returns a connection from the connection array. It will be destroyed if it has been marked for it
	///@returns {any} Connection or undefined
	///@ignore
	static __get_connection = function(_index)
	{
		var _connection = __connections[_index];
		if ((_connection != undefined) && (_connection.is_destroyed()))
			delete _connection;
		
		return _connection;
	}
	
	///@desc Regenerates the connection array, clearing itself of any that may have been destroyed
	///@ignore
	static __regenerate_connections = function()
	{
		var _connections = [];
		var i = 0;
		var _totalConnections = 0;
		repeat (array_length(__connections))
		{
			var _connection = __get_connection(i++);
			if (_connection == undefined) continue;
			
			_connections[_totalConnections++] = _connection;
		}
		
		array_resize(_connections, _totalConnections);
	}
	
	__connections = [];
}