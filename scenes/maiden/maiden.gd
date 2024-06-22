extends CharacterBody2D

signal character_hit;

const CharacterStates: Dictionary = {
	IDLE = "idle",
	JUMP = "jump",
	ATTACK = "attack",
	UP_TO_FALL = "uptofall",
	WALK = "walk",
	DEATH = "death",
	HURT = "hurt",
};

const CharacterActions: Dictionary = {
	UP = "move_up",
	LEFT = "move_left",
	DOWN = "move_down",
	RIGHT = "move_right",
	JUMP = "jump",
	DASH = "dash",
	SLIDE = "slide",
	RUN = "run",
	CROUCH = "crouch",
	ATTACK = "attack",
};

const CharacterAnimations: Dictionary = {
	ATTACK_A = "attack_a",
	ATTACK_B = "attack_b",
	CROUCH = "crouch",
	DASH = "dash",
	DASH_ATTACK = "dash_attack",
	DEATH = "death",
	EDGE_GRAB = "edge_grab",
	EDGE_IDLE = "edge_idle",
	FALL = "fall",
	HURT = "hurt",
	IDLE = "idle",
	JUMP = "jump",
	LADDER_GRAB = "ladder_grab",
	SLIDE = "slide",
	UP_TO_FALL = "up_to_fall",
	WALK = "walk",
	WALL_SLIDE = "wall_slide",
};

var CharacterStats: Dictionary = {
	HEALTH = 3
};

@export var character_speed = 125.0;
@export var jump_velocity = 300.0;

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity");
var character_direction: float;
var is_character_alive: bool = true;
var is_character_hurt: bool = false;
var is_character_falling: bool = false;
var is_character_attacking: bool = false;

@onready var character: CharacterBody2D = $".";
@onready var collision: CollisionShape2D = $CollisionShape2D;
@onready var animator_fliper: Node2D = $AnimatorFliper
@onready var animator: AnimatedSprite2D = $AnimatorFliper/AnimatedSprite2D;
@onready var state_machine: Node = $StateMachine;


func _ready() -> void:
	character.motion_mode = CharacterBody2D.MOTION_MODE_GROUNDED;
	character.collision_layer = 2;
	state_machine.states_ready.connect(_on_state_machine_states_ready);
#}


func _physics_process(delta: float) -> void:
	if not is_character_alive:
		return;
	character_direction = Input.get_axis(CharacterActions.LEFT, CharacterActions.RIGHT);
	_handle_movement(delta);
	_handle_character_stats();
#}


func _handle_character_stats() -> void:
	if CharacterStats.HEALTH == 0:
		is_character_alive = false;
		state_machine.force_state_transition(CharacterStates.DEATH);
#}


func _handle_movement(delta: float) -> void:

	if character.is_character_attacking:
		return

	if not is_on_floor():
		velocity.y += gravity * delta;

	## FLIP animator | Using another Node2D "animator_fliper" to flip, cause animations were offset;
	if character_direction > 0:
		animator_fliper.scale.x = 1;
	elif character_direction < 0:
		animator_fliper.scale.x = -1;

	# MOVE character;
	if character_direction:
		velocity.x = character_direction * character_speed;
	else:
		velocity.x = move_toward(velocity.x, 0, character_speed);

	move_and_slide();
#}


func _on_state_machine_states_ready() -> void:
	_connect_children_state_signals();
	state_machine.force_state_transition(CharacterStates.IDLE);
#}


func _connect_children_state_signals() -> void:
	for key in state_machine.states:
		var state = state_machine.states[key];
		if state is State:
			state.character = character;
#}
