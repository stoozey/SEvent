function Event() constructor
{
	static connect = function(_onFire, _flags)
	{
		__regenerate_connections();
		
		var _connection = new __sevent_class_connection(_onFire, _flags);
		array_push(__connections, _connection);
	}
	
	static fire = function()
	{
		var _args = array_create(argument_count);
		var i = 0;
		repeat (argument_count)
		{
			_args[i] = argument[i];
			i++;
		}

		var i = 0;
		repeat (array_length(__connections))
		{
			var _connection = __get_connection(i++);
			if (_connection == undefined) continue;
			
			_connection.fire(_args);
		}
	}
	
	static __get_connection = function(_index)
	{
		var _connection = __connections[_index];
		if ((_connection != undefined) && (_connection.is_destroyed()))
			delete _connection;
		
		return _connection;
	}
	
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