## Maiden Jump State
extends State;

var is_jumping_peak: bool = false;

func _ready() -> void:
	super();
#}


func enter() -> void:
	super();
	character.animator.play(character.CharacterAnimations.JUMP);
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
		state_transitioned.emit(self, character.CharacterStates.UP_TO_FALL);
		return;
#}


func _apply_jump_force() -> void:
	character.velocity.y = character.jump_velocity * (-1);
#}
