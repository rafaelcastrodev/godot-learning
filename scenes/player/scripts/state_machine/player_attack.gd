class_name PlayerAttack;
extends PlayerState;


func _ready() -> void:
	super();
#}


func enter() -> void:
	super();
	animator.play("attack");
#}


func exit() -> void:
	super();
#}


# Updates every _process() update (When state is_active)
func update(delta: float) -> void:
	pass
#}


# Updates every _physics_process() update (When state is_active)
func physics_update(delta: float) -> void:
	pass;
#}

