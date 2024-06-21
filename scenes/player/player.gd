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

const WALKING_SPEED = 60.0;
const RUNNING_SPEED = 100.0;
const JUMP_VELOCITY = 300.0;

var _is_running: bool = false;
var _is_attacking: bool = false;
var _is_jumping: bool = false;
var _current_action: String = "";
var _current_delta: float;
var _character_direction: Vector2;

const NORMAL_SCALE = Vector2(0.15, 0.08);  # Shadow's normal size
var _target_scale = NORMAL_SCALE;
var JUMP_SCALE = Vector2(0.10, 0.05);  # Shadow's size during jump (adjust values)
var _lerp_time = 0.1  # Time (in seconds) for smooth scaling

@onready var animator: AnimatedSprite2D = $AnimatedSprite2D;
@onready var sprite_shadow: Sprite2D = $SpriteShadow;
@onready var player: CharacterBody2D = $".";

# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	player.motion_mode = CharacterBody2D.MOTION_MODE_FLOATING;
	animator.play(PlayerAnimations.IDLE);
	animator.animation_finished.connect(_cancel_player_action);
#}


func _physics_process(delta: float) -> void:
	var _character_direction = _get_character_direction_normalized();
	_current_delta = delta;

	handle_player_interactions();
	handle_movement(_character_direction);
	handle_animations(_character_direction, delta);

	move_and_slide();
#}

func _cancel_player_action() -> void:

	match _current_action:
		PlayerActions.ATTACK:
			_is_attacking = false;
		PlayerActions.JUMP:
			_is_jumping = false;
			_handle_shadow_during_jump(Vector2(0.15, 0.08), _current_delta);
#}

func handle_player_interactions() -> void:
		if Input.is_action_pressed(PlayerActions.ATTACK):
			_is_attacking = true;

		if Input.is_action_pressed(PlayerActions.JUMP) && not _is_jumping:
			_is_jumping = true;
#}


func handle_movement(_character_direction) -> void:
	if _is_attacking:
		velocity = Vector2.ZERO;
		return;

	if _character_direction:
		var speed: float = WALKING_SPEED;

		if Input.is_action_pressed(PlayerActions.RUN):
			_is_running = true;
			speed = RUNNING_SPEED;
		else:
			_is_running = false;

		velocity = _character_direction * speed;
	else:
		velocity = velocity.move_toward(Vector2.ZERO, WALKING_SPEED);

	if _is_jumping:
		#_handle_jumping();
		pass;
#}


func handle_animations(_character_direction, delta: float) -> void:

	if _is_attacking:
		animator.play(PlayerAnimations.ATTACK);
		_current_action = PlayerAnimations.ATTACK;
		return;

	if _character_direction == Vector2.ZERO:
		animator.play(PlayerAnimations.IDLE);
		_current_action = PlayerAnimations.IDLE;

		#if _is_jumping:
			#_handle_jumping();
			#return;
		return;

	if _character_direction.x > 0:
		animator.flip_h = false;
	if _character_direction.x < 0:
		animator.flip_h = true;

	if _is_running:
		animator.play(PlayerAnimations.RUN);
		_current_action = PlayerAnimations.RUN;

		#if _is_jumping:
			#_handle_jumping();
			#return;
		return;

	if _is_jumping:
		_handle_jumping(delta);
		return;

	animator.play(PlayerAnimations.WALK);
	_current_action = PlayerAnimations.WALK;
#}


func _handle_jumping(delta: float) -> void:
	animator.play(PlayerAnimations.JUMP);
	_current_action = PlayerAnimations.JUMP;
	_target_scale = JUMP_SCALE;
	_handle_shadow_during_jump(Vector2(0.10, 0.05), delta);
#}


func _handle_shadow_during_jump(scale: Vector2, delta: float) -> void:
	#sprite_shadow.scale = lerp(scale, _target_scale, min(delta / _lerp_time, 1.5));
	pass;
#}


func _get_character_direction_normalized():
	return Input.get_vector(PlayerActions.LEFT, PlayerActions.RIGHT, PlayerActions.UP, PlayerActions.DOWN).normalized();
#}
