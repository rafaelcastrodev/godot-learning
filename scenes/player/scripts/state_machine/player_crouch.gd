class_name PlayerCrouch;
extends PlayerState;


func _ready() -> void:
	super();
#}


func enter() -> void:
	super();
	owner.character_speed = 30.0;
	animator.play("crouch");
#}


func exit() -> void:
	super();
#}


# Updates every _process() update (When state is_active)
func update(delta: float) -> void:
	return;
	if owner.is_character_crouching:
		return;

	if owner.character_direction == Vector2.ZERO:
		state_transitioned.emit(self, "idle");
		return;

	state_transitioned.emit(self, "walk");
#}


# Updates every _physics_process() update (When state is_active)
func physics_update(delta: float) -> void:
	pass;
#}


