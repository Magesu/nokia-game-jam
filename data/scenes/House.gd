extends Area2D

# Declare member variables here. Examples:
var storage = []
export var storage_limit = 3

# Box texture for the ui
var storage_box_texture = preload("res://data/sprites/house_storage_box.png")

# Nodes
onready var sprite = get_node("Sprite")
onready var storage_ui = get_node("Storage")

# Called when the node enters the scene tree for the first time.
func _ready():
	# MOAR MATH for adjusting sprite position
	sprite.offset.x = -sprite.texture.get_width()/2
	sprite.offset.y = -sprite.texture.get_height()
	
	# Creates the necessary amount of storage boxes in the ui
	for i in storage_limit:
		var new_storage_box = TextureRect.new()
		new_storage_box.name = "Slot" + str(i+1)
		new_storage_box.texture = storage_box_texture
		storage_ui.add_child(new_storage_box)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _store(item):
	# Checks if there's space at home, if there is add item to storage and move it to the boxes
	if storage.size() < storage_limit:
		item.currentState = item.STATES.STORED
		storage.append(item)
		item.global_position = storage_ui.get_child(storage.size()-1).get_global_position() + Vector2(6,6)

func _withdraw():
	# Removes an item from storage and returns it, if storage is empty returns null
	var stored_item = storage.pop_back()
	# Check if there's a returnable item in storage, if there is sets the necessary values
	if stored_item != null:
		stored_item.currentState = stored_item.STATES.PICKED_UP
	return stored_item
