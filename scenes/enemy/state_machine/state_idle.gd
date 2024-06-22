## Enemy Idle State
extends State;


func _ready() -> void:
	super();
#}


func enter() -> void:
	super();
	character.animator.play(character.EnemyAnimations.IDLE);
#}


func exit() -> void:
	super();
#}


func update(delta: float) -> void:
	pass;
#}



func physics_update(delta: float) -> void:
	pass;
#}

