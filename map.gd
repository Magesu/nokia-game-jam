extends Node2D


# Declare member variables here. Examples:
export var speed = 50
var move_cooldown = 0
var width = 135
var height = 94


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


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
	
	print(position)

