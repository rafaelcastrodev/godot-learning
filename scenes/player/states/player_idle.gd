extends State;
"""
State PlayerIdle
"""

# Runs when the state is entered
func enter() -> void:
	super();
	state_animated.emit("idle");
	print_debug("Enter Idle");
#}


# Runs when the state is exited
func exit() -> void:
	pass;
#}


# Updates every _process() update (When state is active)
func update() -> void:
	pass;
#}


# Updates every _physics_process() update (When state is active)
func physics_update() -> void:
	pass;
#}
