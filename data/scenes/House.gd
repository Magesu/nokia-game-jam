extends Area2D

# Declare member variables here. Examples:
enum TYPES {HOMELESS, WOOD_CABIN, ROCK_HUT, LEAF_BUNGALOW, WOODEN_MANSION, STONE_TOWER, TREE_HOUSE}
enum MATERIAL_TYPES {WOOD, ROCK, LEAF}
var current_type = TYPES.HOMELESS
var current_stage = 0
var storage = []
var storage_limit

# Box texture for the ui
var storage_box_texture = preload("res://data/sprites/house_storage_box.png")

# Nodes
onready var sprite = get_node("Sprite")
onready var storage_ui = get_node("Storage")
onready var game = self.get_parent().get_parent()

# Signals
signal upgrade_house(new_house)

# Called when the node enters the scene tree for the first time.
func _ready():
	# Sets the house's sprite
	match current_type:
		TYPES.HOMELESS:
			sprite.texture = load("res://data/sprites/bench.png")
		TYPES.WOOD_CABIN:
			sprite.texture = load("res://data/sprites/wood_cabin.png")
		TYPES.ROCK_HUT:
			sprite.texture = load("res://data/sprites/rock_hut.png")
		TYPES.LEAF_BUNGALOW:
			sprite.texture = load("res://data/sprites/leaf_bungalow.png")
		TYPES.WOODEN_MANSION:
			sprite.texture = load("res://data/sprites/wooden_mansion.png")
		TYPES.STONE_TOWER:
			sprite.texture = load("res://data/sprites/stone_tower.png")
		TYPES.TREE_HOUSE:
			sprite.texture = load("res://data/sprites/tree_house.png")
	
	# MOAR MATH for adjusting sprite position
	sprite.offset.x = -sprite.texture.get_width()/2
	sprite.offset.y = -sprite.texture.get_height()
	
	match current_stage:
		0: storage_limit = 1
		1: storage_limit = 3
		2: storage_limit = 5
	
	# Creates the necessary amount of storage boxes in the ui
	for i in storage_limit:
		var new_storage_box = TextureRect.new()
		new_storage_box.name = "Slot" + str(i+1)
		new_storage_box.texture = storage_box_texture
		storage_ui.add_child(new_storage_box)
	
	connect("upgrade_house", game, "_on_House_upgrade_house")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _store(item):
	# Checks if there's space at home, if there is add item to storage and move it to the boxes
	if storage.size() < storage_limit:
		item.currentState = item.STATES.STORED
		storage.append(item)
		item.global_position = storage_ui.get_child(storage.size()-1).get_global_position() + Vector2(6,6)
		if storage.size() == storage_limit:
			
			var storage_materials = []
			for item in storage:
				storage_materials.append(item.material_type)
			
			var wood_quantity = storage_materials.count(MATERIAL_TYPES.WOOD)
			var rock_quantity = storage_materials.count(MATERIAL_TYPES.ROCK)
			var leaf_quantity = storage_materials.count(MATERIAL_TYPES.LEAF)
			
			var new_house
			
			match current_stage:
				0:
					if wood_quantity > 0:
						new_house = TYPES.WOOD_CABIN
					if rock_quantity > 0:
						new_house = TYPES.ROCK_HUT
					if leaf_quantity > 0:
						new_house = TYPES.LEAF_BUNGALOW
				1:
					if wood_quantity > 0:
						new_house = TYPES.WOODEN_MANSION
					if rock_quantity > 0:
						new_house = TYPES.STONE_TOWER
					if leaf_quantity > 0:
						new_house = TYPES.TREE_HOUSE
				2:
					pass
			
			emit_signal("upgrade_house",new_house)

func _withdraw():
	# Removes an item from storage and returns it, if storage is empty returns null
	var stored_item = storage.pop_back()
	# Check if there's a returnable item in storage, if there is sets the necessary values
	if stored_item != null:
		stored_item.currentState = stored_item.STATES.PICKED_UP
	return stored_item
