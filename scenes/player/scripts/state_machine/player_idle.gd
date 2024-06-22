class_name PlayerIdle;
extends PlayerState;


func _ready() -> void:
	super();
#}


func enter() -> void:
	super();
	owner.velocity = Vector2.ZERO;
	print("State: Idle")
	animator.play("idle");
#}


func exit() -> void:
	super();
#}


# Updates every _process() update (When state is_active)
func update(delta: float) -> void:

	if owner.character_direction == Vector2.ZERO:
		return;

	if owner.is_character_running:
		state_transitioned.emit(self, "run");
		return;

	state_transitioned.emit(self, "walk");
#}


# Updates every _physics_process() update (When state is_active)
func physics_update(delta: float) -> void:
	pass;
#}

