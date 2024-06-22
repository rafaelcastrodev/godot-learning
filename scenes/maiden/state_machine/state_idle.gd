## Maiden Idle State
extends State;


func _ready() -> void:
	super();
#}


func enter() -> void:
	super();
	character.velocity = Vector2.ZERO;
	animator.play(character.PlayerAnimations.IDLE);
#}


func exit() -> void:
	super();
#}


func update(delta: float) -> void:

	if not character.character_direction:
		return;

	state_transitioned.emit(self, character.PlayerStates.WALK);
#}



func physics_update(delta: float) -> void:
	if character.is_on_floor() and Input.is_action_just_pressed(character.PlayerActions.JUMP):
		state_transitioned.emit(self, character.PlayerStates.JUMP);
#}

