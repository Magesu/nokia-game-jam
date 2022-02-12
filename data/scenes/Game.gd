extends Node

# Variables
var music:AudioStream = preload("res://data/music/tune.wav")

export var menu_sel = 0
var avail_ending = 0

var current_stage = -2
var house_holder
var map_offset = Vector2(0,0)
var player_offset = Vector2(40, 27)

onready var anim_player = get_node("CanvasModulate/AnimationPlayer")

# Scenes
var player_scene = preload("res://data/scenes/Player.tscn")
var intro_scene = preload("res://data/scenes/Intro.tscn")
var gallery_scene = preload("res://data/scenes/Gallery.tscn")
var stage_0_scene = preload("res://stage0.tscn")
var stage_1_scene = preload("res://stage1.tscn")
var stage_2_scene = preload("res://stage2.tscn")

var ending_scene = preload("res://data/scenes/Ending.tscn")

func _ready() -> void:
	fade_in()
	AudioManager.play_music(music)
	#$UI/AnimationPlayer.play("New Anim")

func _process(_delta):
	if !anim_player.is_playing():
		if current_stage == -2:
			if Input.is_action_just_pressed("player_action"):
				if menu_sel == 0:
					anim_player.play("Fade")
					yield(anim_player, "animation_finished")
					fade_in()
					open_intro()
					current_stage += 1
					
				elif menu_sel == 1:
					var gallery = gallery_scene.instance()
					gallery.avail_endings = avail_ending
					self.add_child(gallery)
					menu_sel = 10
					
				elif menu_sel == 2:
					get_tree().quit()

			elif Input.is_action_just_pressed("player_down"):
				if menu_sel < 2:
					menu_sel += 1
			
			elif Input.is_action_just_pressed("player_up"):
				if menu_sel > 0:
					menu_sel -= 1

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
					#encoding to enable the gallery (according to child order on the gallery scene)
					avail_ending += 1<<2
				ENDINGS.WOOD_NECRONOMICON:
					ending_scene = preload("res://data/scenes/NecronomiconWoodEnding.tscn")
					avail_ending += 1<<1
				ENDINGS.WOOD_BAT:
					ending_scene = preload("res://data/scenes/BatWoodEnding.tscn")
					avail_ending += 1<<3
				ENDINGS.ROCK_NORMAL:
					ending_scene = preload("res://data/scenes/NormalRockEnding.tscn")
					avail_ending += 1<<5
				ENDINGS.ROCK_PICKAXE:
					ending_scene = preload("res://data/scenes/PickaxeRockEnding.tscn")
					avail_ending += 1<<4
				ENDINGS.ROCK_MAGIC_HAT:
					ending_scene = preload("res://data/scenes/MagicHatRockEnding.tscn")
					avail_ending += 1<<6
				ENDINGS.LEAF_NORMAL:
					ending_scene = preload("res://data/scenes/NormalLeafEnding.tscn")
					avail_ending += 1<<8
				ENDINGS.LEAF_SINALIZER:
					ending_scene = preload("res://data/scenes/SinalizerLeafEnding.tscn")
					avail_ending += 1<<7
				ENDINGS.LEAF_CLAPBOARD:
					ending_scene = preload("res://data/scenes/ClapboardLeafEnding.tscn")
					avail_ending += 1<<9
				ENDINGS.MIXED:
					ending_scene = preload("res://data/scenes/MixedEnding.tscn")
					avail_ending += 1<<0

					
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
	var intro = get_node("Intro")
	intro.queue_free()
	open_stage_0()
	fade_in()

func open_stage_0():
	var player = player_scene.instance()
	
	house_holder = 0 # TYPES.HOMELESS
	current_stage += 1
	var stage_0 = stage_0_scene.instance()
	
	player.global_position = stage_0.get_node("House Pos").global_position + Vector2(0,11)
	
	self.add_child(player)
	self.add_child(stage_0)
	
func open_stage_1(new_house):
	house_holder = new_house
	current_stage += 1
	var stage_1 = stage_1_scene.instance()
	stage_1.position = map_offset
	self.add_child(stage_1)
	
	var player = get_node("Player")
	player.global_position = stage_1.get_node("House Pos").global_position + Vector2(0,11)
	
func open_stage_2(new_house):
	house_holder = new_house
	current_stage += 1
	var stage_2 = stage_2_scene.instance()
	stage_2.position = map_offset
	self.add_child(stage_2)
	
	var player = get_node("Player")
	player.global_position = stage_2.get_node("House Pos").global_position + Vector2(0,11)
