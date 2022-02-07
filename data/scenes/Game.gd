extends Node

enum TYPES {HOMELESS, WOOD_CABIN, ROCK_HUT, LEAF_BUNGALOW, WOODEN_MANSION, STONE_TOWER, TREE_HOUSE}
var music:AudioStream = preload("res://data/music/tune.wav")


func _ready() -> void:
	pass
	#AudioManager.play_music(music)
	#$UI/AnimationPlayer.play("New Anim")

func _on_Map_house_data_request():
	var map = get_node("Map")
	
	map.spawn_house(TYPES.WOODEN_MANSION)

func _on_House_upgrade_house(new_house):
	print(new_house)
