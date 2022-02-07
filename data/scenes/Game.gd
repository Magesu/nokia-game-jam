extends Node


var music:AudioStream = preload("res://data/music/tune.wav")

func _ready() -> void:
	pass
	#AudioManager.play_music(music)
	#$UI/AnimationPlayer.play("New Anim")

func _on_House_advance_to_next_day(house_items):
	var house = get_node("Map/House")
	
	var wood_quantity = house_items.count("Wood")
	var rock_quantity = house_items.count("Rock")
	var leaf_quantity = house_items.count("Leaf")
	
	match house.currentStage:
		0:
			if wood_quantity > 0:
				house._change_type(house.TYPES.WOOD_CABIN)
			elif rock_quantity > 0:
				house._change_type(house.TYPES.ROCK_HUT)
			elif leaf_quantity > 0:
				house._change_type(house.TYPES.LEAF_BUNGALOW)
			house.currentStage += 1
		1:
			if wood_quantity > 1:
				house._change_type(house.TYPES.WOODEN_MANSION)
			elif rock_quantity > 1:
				house._change_type(house.TYPES.STONE_TOWER)
			elif leaf_quantity > 1:
				house._change_type(house.TYPES.TREE_HOUSE)
			house.currentStage += 1
	house._reset_ui()
	
