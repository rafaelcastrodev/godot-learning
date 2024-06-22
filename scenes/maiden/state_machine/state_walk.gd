## Maiden Walk State
extends State;


func _ready() -> void:
	super();
#}


func enter() -> void:
	super();
	animator.play(character.PlayerAnimations.WALK);
#}


func exit() -> void:
	super();
#}



func update(delta: float) -> void:

	if not character.character_direction:
		state_transitioned.emit(self, character.PlayerStates.IDLE);
		return;
#}



func physics_update(delta: float) -> void:
	if character.is_on_floor() and Input.is_action_just_pressed(character.PlayerActions.JUMP):
		state_transitioned.emit(self, character.PlayerStates.JUMP);
#}


