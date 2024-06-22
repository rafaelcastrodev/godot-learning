## Maiden Idle State
extends State;


func _ready() -> void:
	super();
#}


func enter() -> void:
	super();
	owner.velocity = Vector2.ZERO;
	animator.play(owner.PlayerAnimations.IDLE);
#}


func exit() -> void:
	super();
#}


func update(delta: float) -> void:

	if not owner.character_direction:
		return;

	state_transitioned.emit(self, owner.PlayerStates.WALK);
#}



func physics_update(delta: float) -> void:
	if owner.is_on_floor() and Input.is_action_just_pressed(owner.PlayerActions.JUMP):
		state_transitioned.emit(self, owner.PlayerStates.JUMP);
#}

