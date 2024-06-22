## Maiden Jump State
extends State;

var is_jumping_peak: bool = false;

func _ready() -> void:
	super();
#}


func enter() -> void:
	super();
	animator.play(character.PlayerAnimations.JUMP);
	is_jumping_peak = false;
	_apply_jump_force();
#}


func exit() -> void:
	super();
#}


func update(delta: float) -> void:
	pass
#}


func physics_update(delta: float) -> void:
	if character.velocity.y > 0:
		animator.play(character.PlayerAnimations.UP_TO_FALL);
		return;
	#if character.velocity.y < 0 and not is_jumping_peak:
		#is_jumping_peak = true;

	if character.is_on_floor():
		state_transitioned.emit(self, character.PlayerStates.IDLE);
#}


func _apply_jump_force() -> void:
	character.velocity.y = character.jump_velocity * (-1);
#}
