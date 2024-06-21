class_name DinoWalk;
extends DinoState;

## owner => Dino(CharacterBody2D), in other words the top parent node

func _ready() -> void:
	super();
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
	if owner.velocity == Vector2.ZERO:
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
