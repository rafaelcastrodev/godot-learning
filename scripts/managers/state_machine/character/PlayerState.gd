extends Node
class_name PlayerState;

var character: CharacterBody2D;
var animatedSprite2D: AnimatedSprite2D;
var state_animation: String;
var next_state: PlayerState = null;

func on_enter():
	animatedSprite2D.play(state_animation);
	print("State enter: ", self.name);

func on_exit():
	print("State enter: ", self.name);

func on_animation_finished(animation_name: String):
	print("animation ended");
