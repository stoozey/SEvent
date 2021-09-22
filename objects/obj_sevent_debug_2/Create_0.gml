jumpCounter = 0;
jump = function() { };

Test1 = function() { show_debug_message("1"); };
Test2 = function() { show_debug_message("2"); };
Test3 = function() { show_debug_message("3"); };
Test4 = function() { show_debug_message("4"); };

sevent_connect("player_jumped", Test1);
sevent_connect("player_jumped", Test2, _SEVENT_CATEGORY_DEFAULT, true);
sevent_connect("player_jumped", Test3);
sevent_connect("player_jumped", Test4);