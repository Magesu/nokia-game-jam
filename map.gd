extends Node2D


# Declare member variables here. Examples:
export var speed = 20
var move_cooldown = 0
var width = 135
var height = 94

export var stage = 0

# Scenes
var house_scene = preload("res://data/scenes/House.tscn")

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
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("player_right"):
		velocity.x -= speed
	if Input.is_action_pressed("player_left"):
		velocity.x += speed
	if Input.is_action_pressed("player_down"):
		velocity.y -= speed
	if Input.is_action_pressed("player_up"):
		velocity.y += speed
		
	position += velocity * delta
	position.x = round(position.x)
	position.y = round(position.y)
	position.x = clamp(position.x, -width+42, width+42)
	position.y = clamp(position.y, -height+24, height+24)

func spawn_house(type):
	var house = house_scene.instance()
	house.current_type = type
	house.current_stage = stage
	house.position = Vector2(0,0)
	
	self.add_child(house)
