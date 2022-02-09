extends Area2D

# Declare member variables here. Examples:
enum TYPES {HOMELESS, WOOD_CABIN, WOODEN_MANSION, TEMPLE, ROCK_HUT, STONE_TOWER, MINE, LEAF_BUNGALOW, TREE_HOUSE, ALIEN_PYRAMID}
enum ENDINGS {WOOD_NORMAL, WOOD_NECRONOMICON, WOOD_BAT, ROCK_NORMAL, ROCK_PICKAXE, ROCK_MAGIC_HAT, LEAF_NORMAL, LEAF_SINALIZER, LEAF_CLAPBOARD, MIXED}
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
signal upgrade_house(new_house,ENDINGS,ending)

# Called when the node enters the scene tree for the first time.
func _ready():
	# Sets the house's sprite
	match current_type:
		TYPES.HOMELESS:
			sprite.texture = load("res://data/sprites/bench.png")
		TYPES.WOOD_CABIN:
			sprite.texture = load("res://data/sprites/wood_cabin.png")
		TYPES.WOODEN_MANSION:
			sprite.texture = load("res://data/sprites/wooden_mansion.png")
		TYPES.TEMPLE:
			sprite.texture = load("res://data/sprites/temple.png")
		TYPES.ROCK_HUT:
			sprite.texture = load("res://data/sprites/rock_hut.png")
		TYPES.STONE_TOWER:
			sprite.texture = load("res://data/sprites/stone_tower.png")
		TYPES.MINE:
			sprite.texture = load("res://data/sprites/mine.png")
		TYPES.LEAF_BUNGALOW:
			sprite.texture = load("res://data/sprites/leaf_bungalow.png")
		TYPES.TREE_HOUSE:
			sprite.texture = load("res://data/sprites/tree_house.png")
		TYPES.ALIEN_PYRAMID:
			sprite.texture = load("res://data/sprites/alien_pyramid.png")
	
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
		if	item.material_type == item.MATERIAL_TYPES.SPECIAL:
			
			var new_house
			var ending
			
			match item.special_type:
				item.SPECIAL_TYPES.NECRONOMICON:
					new_house = TYPES.TEMPLE
				item.SPECIAL_TYPES.BAT:
					ending = ENDINGS.WOOD_BAT
				item.SPECIAL_TYPES.PICKAXE:
					new_house = TYPES.MINE
				item.SPECIAL_TYPES.MAGIC_HAT:
					ending = ENDINGS.ROCK_MAGIC_HAT
				item.SPECIAL_TYPES.SINALIZER:
					new_house = TYPES.ALIEN_PYRAMID
				item.SPECIAL_TYPES.CLAPBOARD:
					ending = ENDINGS.LEAF_CLAPBOARD
			
			emit_signal("upgrade_house",new_house,ENDINGS,ending)
			
		else:
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
				var ending
				
				match current_stage:
					0:
						if wood_quantity > 0:
							new_house = TYPES.WOOD_CABIN
						elif rock_quantity > 0:
							new_house = TYPES.ROCK_HUT
						elif leaf_quantity > 0:
							new_house = TYPES.LEAF_BUNGALOW
					1:
						if wood_quantity > 1:
							new_house = TYPES.WOODEN_MANSION
						elif rock_quantity > 1:
							new_house = TYPES.STONE_TOWER
						elif leaf_quantity > 1:
							new_house = TYPES.TREE_HOUSE
						else:
							self._fall_out()
							return
					2:
						if current_type == TYPES.TEMPLE:
							ending = ENDINGS.WOOD_NECRONOMICON
						elif current_type == TYPES.MINE:
							ending = ENDINGS.ROCK_PICKAXE
						elif current_type == TYPES.ALIEN_PYRAMID:
							ending = ENDINGS.LEAF_SINALIZER
						else:
							if wood_quantity > 2:
								ending = ENDINGS.WOOD_NORMAL
							elif rock_quantity > 2:
								ending = ENDINGS.ROCK_NORMAL
							elif leaf_quantity > 2:
								ending = ENDINGS.LEAF_NORMAL
							else:
								ending = ENDINGS.MIXED
				
				emit_signal("upgrade_house",new_house,ENDINGS,ending)

func _withdraw():
	# Removes an item from storage and returns it, if storage is empty returns null
	var stored_item = storage.pop_back()
	# Check if there's a returnable item in storage, if there is sets the necessary values
	if stored_item != null:
		stored_item.currentState = stored_item.STATES.PICKED_UP
	return stored_item

func _fall_out():
	for item in storage:
		var stored_item = storage.pop_back()
		stored_item.global_position = storage_ui.get_child(storage.size()-1).get_global_position() + Vector2(20,16)
		stored_item.currentState = stored_item.STATES.DROPPED
