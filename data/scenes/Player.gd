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
			
			# Places item at player's feet
			inventory.global_position = Vector2(40,32)
			
			inventory = null
		else: 
			# Detects the objects within range and puts them into an array
			var objects = reach.get_overlapping_areas()
			objects.remove(objects.find(self))
			
			# Checks if any objects at all are within range
			if objects != []:
				# Iterates through all the objects and stores the nearest one in a variable
				var nearest_object = objects[0]
				for object in objects:
					# MATH
					var distance_to_no = self.get_global_position().distance_to(nearest_object.get_global_position())
					var distance_to_o = self.get_global_position().distance_to(object.get_global_position())
					if distance_to_o < distance_to_no:
						nearest_object = object
				
				# If the nearest object is an item, player picks it up
				if nearest_object.is_in_group("item"):
					is_holding = true
					nearest_object.picked_up = true 
					inventory = nearest_object
				elif nearest_object.is_in_group("material source"):
					is_holding = true
					inventory = nearest_object._collect()
				
	
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
