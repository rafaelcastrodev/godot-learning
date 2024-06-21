class_name PlayerStateController;
extends CharacterBody2D

@export var state_machine: PlayerStateMachine;

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = state_machine.current_state.JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * state_machine.current_state.SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, state_machine.current_state.SPEED)

	move_and_slide()
