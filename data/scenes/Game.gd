extends Node

# Variables
enum TYPES {HOMELESS, WOOD_CABIN, ROCK_HUT, LEAF_BUNGALOW, WOODEN_MANSION, STONE_TOWER, TREE_HOUSE}
var music:AudioStream = preload("res://data/music/tune.wav")

var current_stage = 0
var house_holder = TYPES.HOMELESS
var map_offset = Vector2(39,7)

onready var anim_player = get_node("CanvasModulate/AnimationPlayer")

# Scenes
var stage_1_scene = preload("res://stage1.tscn")
var stage_2_scene = preload("res://stage2.tscn")

func _ready() -> void:
	anim_player.play_backwards("Fade")
	yield(anim_player, "animation_finished")
	pass
	#AudioManager.play_music(music)
	#$UI/AnimationPlayer.play("New Anim")

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
			house_holder = new_house
			current_stage += 1
			var stage_1 = stage_1_scene.instance()
			stage_1.position = map_offset
			self.add_child(stage_1)
			
			anim_player.play_backwards("Fade")
			yield(anim_player, "animation_finished")
			
		1:
			house_holder = new_house
			current_stage += 1
			var stage_2 = stage_2_scene.instance()
			stage_2.position = map_offset
			self.add_child(stage_2)
			
			anim_player.play_backwards("Fade")
			yield(anim_player, "animation_finished")
			
		2:
			print("INSERT ENDING HERE BEEP BOOP")
			get_tree().quit()
