## Maiden Attack State
extends State;

var _is_combo: bool = false;

func _ready() -> void:
	super();
#}


func enter() -> void:
	super();
	character.animator.animation_finished.connect(animation_finished);
	character.animator.play(character.CharacterAnimations.ATTACK_A);
	character.is_character_attacking = true;
#}


func exit() -> void:
	super();
#}


func update(delta: float) -> void:
	pass
#}


func physics_update(delta: float) -> void:
	pass
#}

func animation_finished():

	if _is_combo:
		character.animator.play(character.CharacterAnimations.ATTACK_B);
		_is_combo = false;
		return;

	character.is_character_attacking = false;
	state_transitioned.emit(self, character.CharacterStates.IDLE);
#}

func handle_input(event: InputEvent) -> void:

	if Input.is_action_just_pressed(character.CharacterActions.ATTACK):
		_is_combo = true;
#}
