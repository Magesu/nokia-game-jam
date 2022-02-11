extends KinematicBody2D

# Declare member variables here. Examples:
enum MATERIAL_TYPES {WOOD, ROCK, LEAF, SPECIAL}
enum SPECIAL_TYPES {NONE, NECRONOMICON, BAT, PICKAXE, MAGIC_HAT, SINALIZER, CLAPBOARD}
export(MATERIAL_TYPES) var material_type = MATERIAL_TYPES.WOOD
export(SPECIAL_TYPES) var special_type = SPECIAL_TYPES.NONE
enum STATES {DROPPED, PICKED_UP, STORED}
var currentState = STATES.DROPPED

# Nodes
onready var player = get_parent().get_parent().get_node("Player")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	match currentState:
		STATES.DROPPED:
			# Syncs "depth" with the map's
			z_index = 0
			pass
		STATES.PICKED_UP:
			global_position = player.global_position + Vector2(1,-8)
			# Syncs "depth" with the player's
			z_index = int(global_position.y)
		STATES.STORED:
			# Syncs "depth" with the map's
			z_index = 0
			pass
