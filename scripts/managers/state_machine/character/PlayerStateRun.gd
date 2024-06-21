extends PlayerState
## RUN

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	state_animation = "run";
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_animation_finished(animation_name: String):
	pass;
