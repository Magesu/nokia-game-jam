extends Area2D


# Declare member variables here. Examples:


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("AnimatedSprite").play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_just_pressed("player_action"):
		get_node("AnimatedSprite").play("holding");
	if Input.is_action_just_released("player_action"):
		get_node("AnimatedSprite").play("idle");

