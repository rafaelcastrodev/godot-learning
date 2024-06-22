## Maiden Up_To_Fall State
extends State;


func _ready() -> void:
	super();
#}


func enter() -> void:
	super();
	character.animator.play(character.CharacterAnimations.UP_TO_FALL);
#}


func exit() -> void:
	super();
#}


func update(delta: float) -> void:
	pass
#}


func physics_update(delta: float) -> void:

	if not character.is_on_floor():
		character.is_character_falling = true;
		return;

	character.is_character_falling = false;
	state_transitioned.emit(self, character.CharacterStates.IDLE);
#}

