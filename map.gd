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

# Scenes
var house_scene = preload("res://data/scenes/House.tscn")
var item_scene

# Signals
signal house_data_request

# Called when the node enters the scene tree for the first time.
func _ready():
	self.connect("house_data_request", self.get_parent(), "_on_Map_house_data_request")
	emit_signal("house_data_request")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	if move_cooldown == 0:
#		if Input.is_action_pressed("player_right"):
#			position.x -= 1
#			move_cooldown = 1
#		if Input.is_action_pressed("player_left"):
#			position.x += 1
#			move_cooldown = 1
#		if Input.is_action_pressed("player_down"):
#			position.y -= 1
#			move_cooldown = 1
#		if Input.is_action_pressed("player_up"):
#			position.y += 1
#			move_cooldown = 1
#
#	move_cooldown -= delta * speed;
#	if move_cooldown < 0:
#		move_cooldown = 0;
#	var velocity = Vector2.ZERO # The player's movement vector.
#	if Input.is_action_pressed("player_right"):
#		velocity.x -= speed
#	if Input.is_action_pressed("player_left"):
#		velocity.x += speed
#	if Input.is_action_pressed("player_down"):
#		velocity.y -= speed
#	if Input.is_action_pressed("player_up"):
#		velocity.y += speed
#
#	position += velocity * delta
#	position.x = round(position.x)
#	position.y = round(position.y)
#	position.x = clamp(position.x, -width+42, width+42)
#	position.y = clamp(position.y, -height+24, height+24)
	pass

func spawn_house(type):
	var house = house_scene.instance()
	house.current_type = type
	house.current_stage = stage
	house.position = Vector2(0,0)
	
	self.add_child(house)
	
	if stage == 1:
		possible_item_spawn_locations = []
		for i in possible_item_spawn_locations_node_paths.size():
			possible_item_spawn_locations.append(get_node(possible_item_spawn_locations_node_paths[i]).position)
		
		item_spawn_pos = possible_item_spawn_locations[randi() % possible_item_spawn_locations.size()]
		
		if house.current_type == house.TYPES.WOOD_CABIN:
			item_scene = preload("res://data/scenes/Necronomicon.tscn")
		elif house.current_type == house.TYPES.ROCK_HUT:
			item_scene = preload("res://data/scenes/Pickaxe.tscn")
		elif house.current_type == house.TYPES.LEAF_BUNGALOW:
			item_scene = preload("res://data/scenes/Sinalizer.tscn")
		
		if item_scene != null:
			var special_item = item_scene.instance()
			special_item.position = item_spawn_pos
		
			self.add_child(special_item)
	elif stage == 2:
		possible_item_spawn_locations = []
		for i in possible_item_spawn_locations_node_paths.size():
			possible_item_spawn_locations.append(get_node(possible_item_spawn_locations_node_paths[i]).position)
		
		item_spawn_pos = possible_item_spawn_locations[randi() % possible_item_spawn_locations.size()]
		
		if house.current_type == house.TYPES.WOODEN_MANSION:
			item_scene = preload("res://data/scenes/Bat.tscn")
		elif house.current_type == house.TYPES.STONE_TOWER:
			item_scene = preload("res://data/scenes/MagicHat.tscn")
		elif house.current_type == house.TYPES.TREE_HOUSE:
			item_scene = preload("res://data/scenes/Clapboard.tscn")
		
		if item_scene != null:
			var special_item = item_scene.instance()
			special_item.position = item_spawn_pos
		
			self.add_child(special_item)
