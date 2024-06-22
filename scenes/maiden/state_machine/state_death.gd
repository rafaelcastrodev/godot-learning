## Maiden Death State
extends State;

func _ready() -> void:
	super();
#}


func enter() -> void:
	super();
	character.animator.play(character.CharacterAnimations.DEATH);
	#collision.queue_free();
	#TODO restart position
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

