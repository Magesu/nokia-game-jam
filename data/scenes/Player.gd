extends Area2D


# Declare member variables here. Examples:
var is_holding = false
var inventory

#Nodes
onready var reach = get_node("Reach")

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("AnimatedSprite").play("idle")
	is_holding = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("player_action"):
		if is_holding: 
			is_holding = false
			
			inventory.picked_up = false
		else: 
			is_holding = true
			
			# Detects the items within range and puts them into an array
			var items = reach.get_overlapping_areas()
			
			# Checks if any items at all are within range
			if items != null:
				# Iterates through all the items and stores the nearest one in a variable
				var nearest_item = items[0]
				for item in items:
					if item.is_in_group("item"):
						# MATH
						var distance_to_nb = self.get_global_position().distance_to(nearest_item.get_global_position())
						var distance_to_b = self.get_global_position().distance_to(item.get_global_position())
						if distance_to_b < distance_to_nb:
							nearest_item = item
				# Picks the nearest item up
				nearest_item.picked_up = true
				inventory = nearest_item

	if Input.is_action_pressed("player_right"):
		if is_holding: get_node("AnimatedSprite").play("holding_right")
		else: get_node("AnimatedSprite").play("walking_right")
		
	elif Input.is_action_pressed("player_left"):
		if is_holding: get_node("AnimatedSprite").play("holding_left")
		else: get_node("AnimatedSprite").play("walking_left")
		
	elif Input.is_action_pressed("player_down"):
		if is_holding: get_node("AnimatedSprite").play("holding_down")
		else: get_node("AnimatedSprite").play("walking_down")
		
	elif Input.is_action_pressed("player_up"):
		if is_holding: get_node("AnimatedSprite").play("holding_up")
		else: get_node("AnimatedSprite").play("walking_up")
		
	else:
		if is_holding: get_node("AnimatedSprite").play("holding")
		else: get_node("AnimatedSprite").play("idle")
