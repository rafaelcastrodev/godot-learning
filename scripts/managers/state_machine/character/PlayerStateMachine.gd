class_name PlayerStateMachine;
extends Node;

const SPEED = 300.0;
const JUMP_VELOCITY = -400.0;

@export var character: CharacterBody2D;
@export var animatedSprite2D: AnimatedSprite2D;
@export var current_state: PlayerState;

var arrayStates: Array[PlayerState];

func _ready() -> void:
	animatedSprite2D.play("attack");
	for child in self.get_children():
		if child is PlayerState:
			child.character = character;
			child.animatedSprite2D = animatedSprite2D;
			arrayStates.append(child);

func _physics_process(delta: float) -> void:

	if current_state.next_state != null:
		change_state(current_state.next_state);

func change_state(new_state: PlayerState):
	current_state.on_exit();
	current_state.next_state = null;
	current_state = new_state;
	current_state.on_enter();

func _on_animations_animation_finished():
	current_state.on_animation_finished(animatedSprite2D.animation);

