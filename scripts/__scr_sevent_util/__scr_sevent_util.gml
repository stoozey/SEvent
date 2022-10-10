function __sevent_print()
{
	var _string = "########## SEvent: ";
    var _i = 0;
    repeat(argument_count)
    {
        _string += string(argument[_i]);
        ++_i;
    }
    
    return show_debug_message(_string);
}