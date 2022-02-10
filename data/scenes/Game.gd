extends Node

# Variables
var music:AudioStream = preload("res://data/music/tune.wav")

var current_stage = -2
var house_holder
var map_offset = Vector2(39,7)
var player_offset = Vector2(40, 27)

onready var anim_player = get_node("CanvasModulate/AnimationPlayer")

# Scenes
var player_scene = preload("res://data/scenes/Player.tscn")
var intro_scene = preload("res://data/scenes/Intro.tscn")
var stage_0_scene = preload("res://stage0.tscn")
var stage_1_scene = preload("res://stage1.tscn")
var stage_2_scene = preload("res://stage2.tscn")

var ending_scene = preload("res://data/scenes/Ending.tscn")

func _ready() -> void:
	fade_in()
	#AudioManager.play_music(music)
	#$UI/AnimationPlayer.play("New Anim")

func _process(_delta):
	if !anim_player.is_playing():
		if current_stage == -2:
			if Input.is_action_just_pressed("player_action"):
				anim_player.play("Fade")
				yield(anim_player, "animation_finished")
				fade_in()
				open_intro()
				current_stage += 1
				
		elif current_stage == 3:
			if Input.is_action_just_pressed("player_action"):
				var ending = self.get_child(self.get_child_count()-1)
				anim_player.play("Fade")
				yield(anim_player, "animation_finished")
				ending.queue_free()
				current_stage = -2
				fade_in()

func _on_Map_house_data_request():
	var map = self.get_child(self.get_child_count()-1)
	
	map.spawn_house(house_holder)

func _on_House_upgrade_house(new_house,ENDINGS,ending):
	anim_player.play("Fade")
	yield(anim_player, "animation_finished")
	
	var player = get_node("Player")
	player.is_holding = false
	
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
			player.queue_free()
			
			match ending:
				ENDINGS.WOOD_NORMAL:
					ending_scene = preload("res://data/scenes/NormalWoodEnding.tscn")
				ENDINGS.WOOD_NECRONOMICON:
					ending_scene = preload("res://data/scenes/NecronomiconWoodEnding.tscn")
				ENDINGS.WOOD_BAT:
					ending_scene = preload("res://data/scenes/BatWoodEnding.tscn")
				ENDINGS.ROCK_NORMAL:
					ending_scene = preload("res://data/scenes/NormalRockEnding.tscn")
				ENDINGS.ROCK_PICKAXE:
					ending_scene = preload("res://data/scenes/PickaxeRockEnding.tscn")
				ENDINGS.ROCK_MAGIC_HAT:
					ending_scene = preload("res://data/scenes/MagicHatRockEnding.tscn")
				ENDINGS.LEAF_NORMAL:
					ending_scene = preload("res://data/scenes/NormalLeafEnding.tscn")
				ENDINGS.LEAF_SINALIZER:
					ending_scene = preload("res://data/scenes/SinalizerLeafEnding.tscn")
				ENDINGS.LEAF_CLAPBOARD:
					ending_scene = preload("res://data/scenes/ClapboardLeafEnding.tscn")
				ENDINGS.MIXED:
					ending_scene = preload("res://data/scenes/MixedEnding.tscn")
					
			ending = ending_scene.instance()
			self.add_child(ending)
			fade_in()

func fade_in():
	anim_player.play_backwards("Fade")
	yield(anim_player, "animation_finished")

func open_intro():
	var intro = intro_scene.instance()
	self.add_child(intro)

func _on_Intro_intro_finished():
	anim_player.play("Fade")
	yield(anim_player, "animation_finished")
	var intro = get_node("Intro")
	intro.queue_free()
	open_stage_0()
	fade_in()

func open_stage_0():
	var player = player_scene.instance()
	player.position = player_offset
	self.add_child(player)

	house_holder = 0 # TYPES.HOMELESS
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
