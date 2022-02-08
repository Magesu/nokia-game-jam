extends Node

# Variables
enum TYPES {HOMELESS, WOOD_CABIN, ROCK_HUT, LEAF_BUNGALOW, WOODEN_MANSION, STONE_TOWER, TREE_HOUSE}
var music:AudioStream = preload("res://data/music/tune.wav")

var current_stage = -1
var house_holder = TYPES.HOMELESS
var map_offset = Vector2(39,7)
var player_offset = Vector2(40, 27)

onready var anim_player = get_node("CanvasModulate/AnimationPlayer")

# Scenes
var player_scene = preload("res://data/scenes/Player.tscn")
var stage_0_scene = preload("res://stage0.tscn")
var stage_1_scene = preload("res://stage1.tscn")
var stage_2_scene = preload("res://stage2.tscn")

var ending = preload("res://data/scenes/Ending.tscn")

func _ready() -> void:	
	pass
	#AudioManager.play_music(music)
	#$UI/AnimationPlayer.play("New Anim")

func _process(_delta):
	if current_stage == -1:
		if Input.is_action_just_pressed("player_action"):
			anim_player.play("Fade")
			yield(anim_player, "animation_finished")
			open_stage_0()
			fade_in()
			
	elif current_stage == 3:
		if Input.is_action_just_pressed("player_action"):
			var cur_ending = self.get_child(self.get_child_count()-1)
			cur_ending.queue_free()
			current_stage = -1

func _on_Map_house_data_request():
	var map = self.get_child(self.get_child_count()-1)
	
	
	map.spawn_house(house_holder)

func _on_House_upgrade_house(new_house):
	
	anim_player.play("Fade")
	yield(anim_player, "animation_finished")
	
	var map = self.get_child(self.get_child_count()-1)
	map.queue_free()
	
	match current_stage:
		0:
			open_stage_1((new_house))
			fade_in()
			
		1:
			open_stage_2(new_house)
			fade_in()
			
		2:
			current_stage+=1
			var player = self.get_child(self.get_child_count()-2)
			player.queue_free()
			var cur_ending = ending.instance()
			self.add_child(cur_ending)
			fade_in()

func fade_out():
	anim_player.play("Fade")
	yield(anim_player, "animation_finished")

func fade_in():
	anim_player.play_backwards("Fade")
	yield(anim_player, "animation_finished")

func open_stage_0():
	var player = player_scene.instance()
	player.position = player_offset
	self.add_child(player)

	house_holder = TYPES.HOMELESS
	current_stage += 1
	var stage_0 = stage_0_scene.instance()
	stage_0.position = map_offset
	self.add_child(stage_0)
	
func open_stage_1(new_house):
	house_holder = new_house
	current_stage += 1
	var stage_1 = stage_1_scene.instance()
	stage_1.position = map_offset
	self.add_child(stage_1)
	
func open_stage_2(new_house):
	house_holder = new_house
	current_stage += 1
	var stage_2 = stage_2_scene.instance()
	stage_2.position = map_offset
	self.add_child(stage_2)
