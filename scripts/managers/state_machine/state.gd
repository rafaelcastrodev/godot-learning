extends Node;
class_name State;
"""
Base State class for the State Machine
"""

signal state_transitioned(source_state, new_state_name);
signal state_animated(animation_name);
var active := false;

func enter() -> void:
	#signal emit for parent node listening
	pass;
#}


func exit() -> void:
		pass;
#}


func update() -> void:
		pass;
#}


func physics_update() -> void:
		pass;
#}

