extends CharacterBody2D;

const SPEED = 150.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var state_machine: StateMachine = $StateMachine;
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D;


func _ready() -> void:
	print_debug("01 - Player Ready");
	state_machine.states_ready.connect(_on_state_machine_states_ready);
	state_machine.force_state_transition("idle");
#}


func _physics_process(delta: float) -> void:
	_handle_movement(delta);
#}


func _handle_movement(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
#}


func _handle_animations(animation_name: String) -> void:
	animated_sprite.play(animation_name);
	print_debug("Animation Played: ", animation_name);
#}


func _on_state_machine_states_ready() -> void:
	#var initial_state: State = state_machine.states.get("idle");
	#initial_state.enter();
	print_debug("04 - StateMachine started")
	_connect_children_state_signals();
#}


func _connect_children_state_signals() -> void:
		print_debug("03 - ", state_machine);
	#for state in state_machine.states:
		#state.state_animated.connect(_handle_animations);
#}
