#macro SEVENT_VERSION "2.2.0"

enum SEVENT_CONNECTION_FLAGS
{
	NONE = 0x00,
	FIRE_ONCE = 0x01,	// Automatically destroys the connection after firing once
}