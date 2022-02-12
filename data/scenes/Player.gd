extends KinematicBody2D

# Sound Stuff
var pick_up_sound:AudioStream = preload("res://data/sfx/pick_up.wav")
var store_in_house_sound:AudioStream = preload("res://data/sfx/store_in_house.wav")

# Declare member variables here. Examples:
export var speed = 40

var is_holding = false
var inventory

#Nodes
onready var reach = get_node("Reach")
onready var fade_player = get_parent().get_node("CanvasModulate/AnimationPlayer")

# Called when the node enters the scene tree for the first time.
func _ready():

	get_node("AnimatedSprite").play("idle")
	is_holding = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# Makes the order of drawing in the screen dependant on the Y coordinate to give the impression of depth
	z_index = int(position.y)
	# Player movement
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("player_right"):
		velocity.x += speed
	if Input.is_action_pressed("player_left"):
		velocity.x -= speed
	if Input.is_action_pressed("player_down"):
		velocity.y += speed
	if Input.is_action_pressed("player_up"):
		velocity.y -= speed

	move_and_slide(velocity)
	
	if !fade_player.is_playing():
		if Input.is_action_just_pressed("player_action"):
			if is_holding:
				# Detects if the house is nearby and stores the house node into a variable
				var house
				var objects = reach.get_overlapping_areas()
				
				for object in objects:
					if object.is_in_group("storage"):
						house = object.get_parent()
						break
				
				# If house exists and the storage has space, store what the player is holding
				if house != null and house.storage.size() < house.storage_limit:
					# Play sound
					AudioManager.play_sfx(store_in_house_sound)
					
					house._store(inventory)
				# Else then places item at player's feet
				else:
					# Play sound
					AudioManager.play_sfx(pick_up_sound)
					
					inventory.global_position = self.global_position + Vector2(1,2)
					inventory.currentState = inventory.STATES.DROPPED
				
				# Turns off is holding and clears inventory
				is_holding = false
				inventory = null
			else: 
				# Detects the objects within range and puts them into an array
				var objects = []
				objects = reach.get_overlapping_bodies()
				objects.append_array(reach.get_overlapping_areas())
				# Filters out unpickable objects
				var temp = []
				for object in objects:
					if object.is_in_group("item"):
						if object.currentState != object.STATES.DROPPED:
							continue
					elif object.is_in_group("storage"):
						if object.get_parent().storage == []:
							continue
					elif object.is_in_group("house"):
						continue
					temp.append(object)
				objects = temp
				
				# Checks if any objects at all are within range
				if objects != []:
					# Play sound
					AudioManager.play_sfx(pick_up_sound)
					
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
						nearest_object.currentState = nearest_object.STATES.PICKED_UP 
						inventory = nearest_object
					# If it's a material source, collects the material aka source is destroyed and material is picked up
					elif nearest_object.is_in_group("material source"):
						is_holding = true
						inventory = nearest_object._collect()
					# If it's a storage, checks if there's stuff in the storage and if there is withdraws the rightmost item
					elif nearest_object.is_in_group("storage"):
						var house_object = (nearest_object.get_parent())._withdraw()
						if house_object != null:
							is_holding = true
							inventory = house_object
						else:
							is_holding = false
	
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
