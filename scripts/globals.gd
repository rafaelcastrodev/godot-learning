extends Node;

signal game_paused(is_game_paused: bool);

var is_game_paused: bool = false;

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		_pause_game();
#}

func _pause_game() -> void:
	if is_game_paused:
		get_tree().paused = false;
	else:
		get_tree().paused = true;

	is_game_paused = get_tree().paused;
	game_paused.emit(is_game_paused);
#}
