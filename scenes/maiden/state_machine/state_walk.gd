## Maiden Walk State
extends State;


func _ready() -> void:
	super();
#}


func enter() -> void:
	super();
	animator.play(owner.PlayerAnimations.WALK);
#}


func exit() -> void:
	super();
#}



func update(delta: float) -> void:

	if not owner.character_direction:
		state_transitioned.emit(self, owner.PlayerStates.IDLE);
		return;
#}



func physics_update(delta: float) -> void:
	if owner.is_on_floor() and Input.is_action_just_pressed(owner.PlayerActions.JUMP):
		state_transitioned.emit(self, owner.PlayerStates.JUMP);
#}


