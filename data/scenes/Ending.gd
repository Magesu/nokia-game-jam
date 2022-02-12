extends Node2D


# Declare member variables here. Examples:
var current_part = 0

# Nodes
onready var game = get_parent()
onready var fade_player = game.get_node("CanvasModulate/AnimationPlayer")
onready var art = get_node("Sprite")
onready var text = get_node("Label")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if !fade_player.is_playing():
		if Input.is_action_just_pressed("player_action"):
			if current_part == 0:
				fade_player.play("Fade")
				yield(fade_player, "animation_finished")
				current_part += 1
				text.visible = false
				art.modulate = Color(1,1,1,1)
				fade_player.play_backwards("Fade")
				yield(fade_player, "animation_finished")
			elif current_part == 1:
				fade_player.play("Fade")
				yield(fade_player, "animation_finished")
				self.queue_free()
				game.current_stage = -2
				fade_player.play_backwards("Fade")
