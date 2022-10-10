function __sevent_class_connection(_onFire, _flags = SEVENT_CONNECTION_FLAGS.NONE) constructor
{
	///@desc Runs __onFire, also manages any flags that have been set
	///@param {array} An array of arguments passed into __onFire
	static fire = function(_args)
	{
		if (!__connected) return;
		
		__onFire(_args);
		
		if (__flags & SEVENT_CONNECTION_FLAGS.FIRE_ONCE)
			destroy();
	}
	
	///@desc Events will call fire() when fired
	static connect = function()
	{
		__connected = true;
	}
	
	///@desc Events will ignore this connection when fired
	static disconnect = function()
	{
		__connected = false;
	}
	
	///@desc Queues the connection to be destroyed, and also disconnects itself
	static destroy = function()
	{
		__isDestroyed = true;
		disconnect();
	}
	
	///@desc Returns whether or not this has been queued for destruction
	///@returns {bool} Queued for destruction
	static is_destroyed = function()
	{
		return __isDestroyed;
	}
	
	__flags = _flags;
	
	__connected = false;
	__isDestroyed = false;
	__onFire = _onFire;
	
	connect();
}