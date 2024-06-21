class_name Dino;
extends CharacterBody2D

@export var speed = 150.0;
@export var jump_velocity = -300.0;

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity");

@onready var collision: CollisionShape2D = $CollisionShape2D;
@onready var animator: AnimatedSprite2D = $AnimatedSprite2D;
@onready var character: CharacterBody2D = $".";
@onready var dino_state_machine: Node = $DinoStateMachine;

func _ready() -> void:
	dino_state_machine.states_ready.connect(_on_state_machine_states_ready);
#}


func _physics_process(delta: float) -> void:
	#_handle_movement(delta);
	pass
#}


func _handle_movement(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta;

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity;

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction: float = Input.get_axis("move_left", "move_right");
	if direction:
		velocity.x = direction * speed;
	else:
		velocity.x = move_toward(velocity.x, 0, speed);

	move_and_slide();
#}


func _on_state_machine_states_ready() -> void:
	_connect_children_state_signals();
	dino_state_machine.force_state_transition("idle");
#}


func _connect_children_state_signals() -> void:
	for key in dino_state_machine.states:
		var state = dino_state_machine.states[key];
		if state is State:
			state.animator = animator;
#}
