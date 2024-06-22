class_name PlayerRun;
extends PlayerState;


func _ready() -> void:
	super();
#}


func enter() -> void:
	super();
	owner.character_speed = 100.0;
	animator.play("run");
#}


func exit() -> void:
	super();
#}


# Updates every _process() update (When state is_active)
func update(delta: float) -> void:

	if owner.is_character_running:
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


