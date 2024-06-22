## Maiden Idle State
extends State;


func _ready() -> void:
	super();
#}


func enter() -> void:
	super();
	character.velocity = Vector2.ZERO;
	character.animator.play(character.CharacterAnimations.IDLE);
#}


func exit() -> void:
	super();
#}


func update(delta: float) -> void:

	if not character.character_direction:
		return;

	state_transitioned.emit(self, character.CharacterStates.WALK);
#}



func physics_update(delta: float) -> void:
	if character.is_on_floor():

		if Input.is_action_just_pressed(character.CharacterActions.JUMP):
			state_transitioned.emit(self, character.CharacterStates.JUMP);

		if Input.is_action_just_pressed(character.CharacterActions.ATTACK):
			state_transitioned.emit(self, character.CharacterStates.ATTACK);

#}

