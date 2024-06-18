extends Node;
class_name State;
"""
Base State class for the Finite State Machine
"""

signal state_transitioned(source_state: State, new_state_name: String);
signal state_animated(animation_name: String);

var is_active: bool = false;

func enter() -> void:
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

