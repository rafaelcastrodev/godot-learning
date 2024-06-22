## Maiden Jump State
extends State;


func _ready() -> void:
	super();
#}


func enter() -> void:
	super();
	animator.play(owner.PlayerAnimations.JUMP);
	_apply_jump_force();
#}


func exit() -> void:
	super();
#}


func update(delta: float) -> void:
	pass
#}


func physics_update(delta: float) -> void:
	if not owner.is_on_floor():
		return;
	state_transitioned.emit(self, owner.PlayerStates.IDLE);
#}


func _apply_jump_force() -> void:
	owner.velocity.y = owner.jump_velocity * (-1);
#}
