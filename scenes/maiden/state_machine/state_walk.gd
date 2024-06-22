## Maiden Walk State
extends State;


func _ready() -> void:
	super();
#}


func enter() -> void:
	super();
	character.animator.play(character.CharacterAnimations.WALK);
#}


func exit() -> void:
	super();
#}



func update(delta: float) -> void:

	if not character.is_on_floor():
		state_transitioned.emit(self, character.CharacterStates.UP_TO_FALL);

	if not character.character_direction:
		state_transitioned.emit(self, character.CharacterStates.IDLE);

#}


func physics_update(delta: float) -> void:
	if character.is_on_floor():

		if Input.is_action_just_pressed(character.CharacterActions.JUMP):
			state_transitioned.emit(self, character.CharacterStates.JUMP);

		if Input.is_action_just_pressed(character.CharacterActions.ATTACK):
			state_transitioned.emit(self, character.CharacterStates.ATTACK);

#}


