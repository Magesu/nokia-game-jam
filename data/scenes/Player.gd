extends Area2D


# Declare member variables here. Examples:
var is_holding = false

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("AnimatedSprite").play("idle")
	is_holding = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("player_action"):
		if is_holding: is_holding = false
		else: is_holding = true

	print(is_holding)

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
		

