extends Node2D


# Declare member variables here. Examples:
var intro_text = ["You are homeless", "You must build a house"]
var current_passage = 0

# Nodes
onready var game = get_parent()
onready var fade_player = game.get_node("CanvasModulate/AnimationPlayer")
onready var text = get_node("Label")

signal intro_finished


# Called when the node enters the scene tree for the first time.
func _ready():
	self.connect("intro_finished", game, "_on_Intro_intro_finished")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):

	text.text = intro_text[current_passage]
	
	if !fade_player.is_playing():
		if Input.is_action_just_pressed("player_action"):
			if current_passage < 1:
				fade_player.play("Fade")
				yield(fade_player, "animation_finished")
				current_passage += 1
				fade_player.play_backwards("Fade")
				yield(fade_player, "animation_finished")
			else:
				fade_player.play("Fade")
				yield(fade_player, "animation_finished")
				emit_signal("intro_finished")
