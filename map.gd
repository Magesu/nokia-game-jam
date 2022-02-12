extends Node2D


# Declare member variables here. Examples:
export var speed = 40
var move_cooldown = 0
var width = 135
var height = 94

export var stage = 0

export(Array,NodePath) var possible_item_spawn_locations_node_paths = []
var possible_item_spawn_locations = []
var item_spawn_pos

# Nodes
onready var house_pos = get_node("House Pos")
onready var player = get_parent().get_node("Player")

# Scenes
var house_scene = preload("res://data/scenes/House.tscn")
var item_scene

# Special items
var necronomicon = preload("res://data/scenes/Necronomicon.tscn")
var pickaxe = preload("res://data/scenes/Pickaxe.tscn")
var sinalizer = preload("res://data/scenes/Sinalizer.tscn")
var bat = preload("res://data/scenes/Bat.tscn")
var hat = preload("res://data/scenes/MagicHat.tscn")
var clapboard = preload("res://data/scenes/Clapboard.tscn")

var possible_bonus_items = [necronomicon, pickaxe, sinalizer, bat, hat, clapboard]

# Signals
signal house_data_request

# Called when the node enters the scene tree for the first time.
func _ready():
	self.connect("house_data_request", self.get_parent(), "_on_Map_house_data_request")
	
	player.global_position = house_pos.global_position + Vector2(0, 11)
	
	emit_signal("house_data_request")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func spawn_house(type):
	var house = house_scene.instance()
	house.current_type = type
	house.current_stage = stage
	house.position = house_pos.position
	
	self.add_child(house)
	
	if stage == 1:
		possible_item_spawn_locations = []
		for i in possible_item_spawn_locations_node_paths.size():
			possible_item_spawn_locations.append(get_node(possible_item_spawn_locations_node_paths[i]).position)
		
		item_spawn_pos = possible_item_spawn_locations[randi() % possible_item_spawn_locations.size()]
		
		if house.current_type == house.TYPES.WOOD_CABIN:
			item_scene = necronomicon
		elif house.current_type == house.TYPES.ROCK_HUT:
			item_scene = pickaxe
		elif house.current_type == house.TYPES.LEAF_BUNGALOW:
			item_scene = sinalizer
		
		if item_scene != null:
			# Removes the guaranteed special item from the possible bonus items
			possible_bonus_items.erase(item_scene)
			
			var special_item = item_scene.instance()
			special_item.position = item_spawn_pos
		
			self.add_child(special_item)
		
		if player.power_up_more_special_items:
			# Creates array with the possible item spawn positions and removes the one used to spawn the guaranteed special item
			var powered_up_possible_spawn_locations = possible_item_spawn_locations
			powered_up_possible_spawn_locations.erase(item_spawn_pos)
			
			# Cycles through each remaining position, spawns a random special item from the possible special items and removes that special item from the list of spawnable bonus items
			for i in powered_up_possible_spawn_locations.size():
				var bonus_item_scene = possible_bonus_items[randi() % possible_bonus_items.size()]
				var bonus_item = bonus_item_scene.instance()
				bonus_item.position = powered_up_possible_spawn_locations[i]
				self.add_child(bonus_item)
				possible_bonus_items.erase(bonus_item_scene)
		
	elif stage == 2:
		possible_item_spawn_locations = []
		for i in possible_item_spawn_locations_node_paths.size():
			possible_item_spawn_locations.append(get_node(possible_item_spawn_locations_node_paths[i]).position)
		
		item_spawn_pos = possible_item_spawn_locations[randi() % possible_item_spawn_locations.size()]
		
		if house.current_type == house.TYPES.WOODEN_MANSION:
			item_scene = bat
		elif house.current_type == house.TYPES.STONE_TOWER:
			item_scene = hat
		elif house.current_type == house.TYPES.TREE_HOUSE:
			item_scene = clapboard
		
		if item_scene != null:
			possible_bonus_items.erase(item_scene)
			
			var special_item = item_scene.instance()
			special_item.position = item_spawn_pos
		
			self.add_child(special_item)
		
		if player.power_up_more_special_items:
			# Creates array with the possible item spawn positions and removes the one used to spawn the guaranteed special item
			var powered_up_possible_spawn_locations = possible_item_spawn_locations
			powered_up_possible_spawn_locations.erase(item_spawn_pos)
			
			# Cycles through each remaining position, spawns a random special item from the possible special items and removes that special item from the list of spawnable bonus items
			for i in powered_up_possible_spawn_locations.size():
				var bonus_item_scene = possible_bonus_items[randi() % possible_bonus_items.size()]
				var bonus_item = bonus_item_scene.instance()
				bonus_item.position = powered_up_possible_spawn_locations[i]
				self.add_child(bonus_item)
				possible_bonus_items.erase(bonus_item_scene)
