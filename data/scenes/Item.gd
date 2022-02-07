extends Area2D

# Declare member variables here. Examples:
enum STATES {DROPPED, PICKED_UP, STORED}
var currentState = STATES.DROPPED

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#Checks what the current state of the items is to decide what do to with it
	match currentState:
		STATES.DROPPED:
			pass
		STATES.PICKED_UP:
			global_position = Vector2(40, 19)
		STATES.STORED:
			pass
