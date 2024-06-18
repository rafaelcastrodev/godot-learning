extends Node;
class_name StateMachine;
"""
State machine for managing States.
"""

signal states_ready;

## State for the StateMachine to start in.
@export var initial_state : State;

var current_state : State;
var states : Dictionary = {}

func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child;
			child.state_transitioned.connect(_on_state_transitioned);

	#if not initial_state:
		#initial_state = get_child(0);

	#initial_state.enter();
	#current_state = initial_state;
	call_deferred( "_trigger_on_states_ready" );
#}


func _trigger_on_states_ready() -> void:
	states_ready.emit();
#}


func _process(_delta : float) -> void:
	if current_state:
		current_state.update();
#}


func _physics_process(_delta : float) -> void:
	if current_state:
		current_state.physics_update();
#}


func force_state_transition(new_state_name: String, close_current_state: bool = false) -> void:
	var new_state : State = states.get(new_state_name.to_lower());

	if not new_state:
		printerr(
			"Cannot force state transition. New state is empty or transition state name does
			not match a state's name"
			);
		return;

	if current_state and close_current_state:
		current_state.exit();
		new_state.active = false;
		current_state.active = false;
	else:
		new_state.enter();
		new_state.active = true;
		current_state = new_state;
#}


func _on_state_transitioned(source_state : State, new_state_name : String) -> void:
	# Source state has to be the current active state
	if source_state != current_state:
		#printerr("Cannot change to "+ new_state_name +" state from " + source_state + " state");
		printerr("Cannot change to new state state from source state");
		return;

	if not current_state:
		printerr("Current state is null, cannot transition");
		return;

	# Checking for the next state. If both are fine, the transition can be made.
	var new_state : State = states.get(new_state_name.to_lower());
	if not new_state:
		printerr("New state is empty or transition state name does not match a state's name");

	if current_state:
		current_state.exit(); # Exit the old state
		new_state.active = false;
		current_state.active = false;

	new_state.enter(); # Exit the new state
	new_state.active = true;
	current_state = new_state;
	print_debug("_on_state_transitioned");
#}

