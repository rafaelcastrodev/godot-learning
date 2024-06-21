class_name Dino;
extends CharacterBody2D

const PlayerActions: Dictionary = {
	UP = "move_up",
	LEFT = "move_left",
	DOWN = "move_down",
	RIGHT = "move_right",
	JUMP = "jump",
	RUN = "run",
	CROUCH = "crouch",
	ATTACK = "attack",
};

const PlayerAnimations: Dictionary = {
	IDLE = "idle",
	WALK = "walk",
	JUMP = "jump",
	RUN = "run",
	CROUCH = "crouch",
	ATTACK = "attack",
	HURT = "hurt",
};

@export var character_speed = 60.0;
@export var jump_velocity = -300.0;

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity");
var character_direction: Vector2;
var is_character_running: bool = false;

@onready var collision: CollisionShape2D = $CollisionShape2D;
@onready var animator: AnimatedSprite2D = $AnimatedSprite2D;
@onready var character: CharacterBody2D = $".";
@onready var dino_state_machine: Node = $DinoStateMachine;

func _ready() -> void:
	dino_state_machine.states_ready.connect(_on_state_machine_states_ready);
#}


func _physics_process(delta: float) -> void:
	character_direction = _getcharacter_direction_normalized();
	_handle_movement(delta);
#}

# The state machine subscribes to node callbacks and delegates them to the state objects.
func _unhandled_input(event: InputEvent) -> void:
	if dino_state_machine.current_state:
		is_character_running = Input.is_action_pressed("run", true);
#}


func _handle_movement(delta: float) -> void:

	if character_direction == Vector2.ZERO:
		return;

	# MOVE character;
	if character_direction:
		velocity = character_direction * character_speed;
	else:
		velocity = velocity.move_toward(Vector2.ZERO, character_speed);

	# FLIP animator;
	if character_direction.x > 0:
		animator.flip_h = false;
	else:
		animator.flip_h = true;

	move_and_slide();
#}


func _on_state_machine_states_ready() -> void:
	_connect_children_state_signals();
	dino_state_machine.force_state_transition("idle");
#}


func _connect_children_state_signals() -> void:
	for key in dino_state_machine.states:
		var state = dino_state_machine.states[key];
		if state is DinoState:
			state.animator = animator;
			state.collision = collision;
			state.character = character;
#}

func _getcharacter_direction_normalized():
	return Input.get_vector(PlayerActions.LEFT, PlayerActions.RIGHT, PlayerActions.UP, PlayerActions.DOWN).normalized();
#}
