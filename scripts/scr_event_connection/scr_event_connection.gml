enum SEVENT_CONNECTION_FLAGS
{
	NONE = 0x00,
	FIRE_ONCE = 0x01,
}

function __sevent_class_connection(_onFire, _flags = SEVENT_CONNECTION_FLAGS.NONE) constructor
{
	static fire = function(_args)
	{
		if (!__connected) return;
		
		__onFire(_args);
		
		if (__flags & SEVENT_CONNECTION_FLAGS.FIRE_ONCE)
			destroy();
	}
	
	static is_destroyed = function()
	{
		return __isDestroyed;
	}
	
	static connect = function()
	{
		__connected = true;
	}
	
	static disconnect = function()
	{
		__connected = false;
	}
	
	static destroy = function()
	{
		__isDestroyed = true;
		disconnect();
	}
	
	__flags = _flags;
	
	__connected = false;
	__isDestroyed = false;
	__onFire = _onFire;
	
	connect();
}