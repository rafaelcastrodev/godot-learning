## Maiden Hurt State
extends State;

func _ready() -> void:
	super();
#}


func enter() -> void:
	super();
	character.animator.play(character.CharacterAnimations.HURT);
#}


func exit() -> void:
	super();
#}


func update(delta: float) -> void:
	pass
#}


func physics_update(delta: float) -> void:
	return;
	if character.is_on_floor() and Input.is_action_just_pressed(character.CharacterActions.JUMP):
		state_transitioned.emit(self, character.CharacterStates.DEATH);
#}

