class_name DinoWalk;
extends DinoState;


func _ready() -> void:
	super();
#}


func enter() -> void:
	super();
	owner.character_speed = 60.0;
	print("State: Walk");
	animator.play("walk");
#}


func exit() -> void:
	super();
#}


# Updates every _process() update (When state is_active)
func update(delta: float) -> void:

	if owner.character_direction == Vector2.ZERO:
		state_transitioned.emit(self, "idle");
		return;

	if owner.is_character_running:
		state_transitioned.emit(self, "run");
		return;
#}


# Updates every _physics_process() update (When state is_active)
func physics_update(delta: float) -> void:
	pass;
#}

