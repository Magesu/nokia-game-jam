extends Area2D


# Declare member variables here. Examples:
export var speed = 0.01
var screen_size
var move_cooldown = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if move_cooldown == 0:
		if Input.is_action_pressed("player_right"):
			position.x += 1
			move_cooldown = speed
		if Input.is_action_pressed("player_left"):
			position.x -= 1
			move_cooldown = speed
		if Input.is_action_pressed("player_down"):
			position.y += 1
			move_cooldown = speed
		if Input.is_action_pressed("player_up"):
			position.y -= 1
			move_cooldown = speed
	
	move_cooldown -= delta;
	if move_cooldown < 0:
		move_cooldown = 0;
	
	print(position)

