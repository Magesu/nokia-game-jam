extends Area2D

# Declare member variables here. Examples:
var storage = []
var storage_limit = 3

# Nodes
onready var sprite = get_node("Sprite")
onready var storage_ui = get_node("Storage")

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.offset.x = -sprite.texture.get_width()/2
	sprite.offset.y = -sprite.texture.get_height()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _store(item):
	# Checks if there's space at home, if there is add item to storage and move it to the boxes
	if storage.size() < storage_limit:
		item.picked_up = false
		item.stored = true
		storage.append(item)
		item.global_position = storage_ui.get_child(storage.size()-1).get_global_position() + Vector2(6,6)

func _withdraw():
	# Removes an item from storage and returns it, if storage is empty returns null
	var stored_item = storage.pop_back()
	# Check if there's a returnable item in storage, if there is sets the necessary values
	if stored_item != null:
		stored_item.stored = false
		stored_item.picked_up = true
	return stored_item
