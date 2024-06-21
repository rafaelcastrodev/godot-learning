class_name DinoIdle;
extends DinoState;

## owner => Dino(CharacterBody2D), in other words the top parent node

func _ready() -> void:
	super();
	owner.velocity = Vector2.ZERO;
#}


func enter() -> void:
	super();
	animator.play("idle");
#}


func exit() -> void:
	super();
#}


# Updates every _process() update (When state is_active)
func update(delta: float) -> void:

	if Input.get_vector("move_left", "move_right", "move_up", "move_down"):
		pass

	if Input.is_action_just_pressed("attack"):
		pass

	if Input.is_action_just_pressed("jump"):
		pass
#}


# Updates every _physics_process() update (When state is_active)
func physics_update(delta: float) -> void:
	pass;
#}
