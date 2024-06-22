class_name Enemy;
extends CharacterBody2D;

enum EnemyDirections {
	LEFT = -1,
	RIGHT = 1,
}

const EnemyStates: Dictionary = {
	IDLE = "idle",
	WALK = "idle",
	HURT = "hurt",
	ATTACK = "attack",
};

const EnemyAnimations: Dictionary = {
	IDLE = "idle",
	WALK = "idle",
	HURT = "hurt",
	ATTACK = "attack",
};

const EnemyStats: Dictionary = {
	HEALTH = 2
};

@export var enemy_speed = 50.0;

var enemy_direction: int = EnemyDirections.RIGHT;

@onready var enemy: CharacterBody2D = $".";
@onready var collision: CollisionShape2D = $CollisionShape2D;
@onready var animator: AnimatedSprite2D = $AnimatedSprite2D;
@onready var state_machine: Node = $StateMachine;
@onready var ray_cast_right: RayCast2D = $RightRayCast2D;
@onready var ray_cast_left: RayCast2D = $LeftRayCast2D;


func _ready() -> void:
	enemy.motion_mode = CharacterBody2D.MOTION_MODE_GROUNDED;
	state_machine.states_ready.connect(_on_state_machine_states_ready);
#}


func _physics_process(delta: float) -> void:
	_handle_movement(delta);
#}


func _handle_movement(delta: float) -> void:

	if(ray_cast_right.is_colliding()):
		enemy_direction = EnemyDirections.LEFT;
		animator.flip_h = true;
	if ray_cast_left.is_colliding():
		enemy_direction = EnemyDirections.RIGHT;
		animator.flip_h = false;

	var desired_velocity = Vector2(enemy_direction * enemy_speed, velocity.y);
	velocity = desired_velocity * enemy_speed * delta;

	move_and_slide();
#}


func _on_state_machine_states_ready() -> void:
	_connect_children_state_signals();
	state_machine.force_state_transition(EnemyStates.IDLE);
#}


func _connect_children_state_signals() -> void:
	for key in state_machine.states:
		var state = state_machine.states[key];
		if state is State:
			state.character = enemy;
#}
