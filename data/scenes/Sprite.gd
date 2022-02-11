extends Sprite

var speed = 10

var sfx:AudioStream = preload("res://data/sfx/sfx01.wav")
var _original_position:Vector2 = Vector2()
var _position:Vector2 = Vector2()
var _velocity:Vector2 = Vector2()


func _ready() -> void:
	_original_position = position


func _process(delta: float) -> void:
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("player_right"):
		velocity.x += speed
	if Input.is_action_pressed("player_left"):
		velocity.x -= speed
	if Input.is_action_pressed("player_down"):
		velocity.y += speed
	if Input.is_action_pressed("player_up"):
		velocity.y -= speed
		
	position += velocity * delta
	
	print(position)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		if _position == Vector2.ZERO:
			AudioManager.play_sfx(sfx)
			_velocity.y = 30
