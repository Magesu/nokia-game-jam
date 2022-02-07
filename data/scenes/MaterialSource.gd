extends Area2D

# Declare member variables here.

#Scenes
export(String, FILE, "*.tscn") var material_scene_path = "res://data/scenes/ItemTemplate.tscn"
var material_scene

#Nodes
onready var map = self.get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	material_scene = load(material_scene_path)

func _collect():
	# Preparing the material to create the material
	var material_instance = material_scene.instance()
	material_instance.currentState = material_instance.STATES.PICKED_UP
	
	# Material creating
	map.add_child(material_instance)
	
	# Material source destroying
	self.queue_free()
	
	# Returning material so it can be put into player's inventory
	return material_instance
