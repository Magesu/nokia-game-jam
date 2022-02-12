extends Control

# Sound
var back_bweep:AudioStream = preload("res://data/sfx/back_bweep.wav")
var blip:AudioStream = preload("res://data/sfx/art_blip.wav")

# Declare member variables here. Examples:
export(int) var avail_endings

# Called when the node enters the scene tree for the first time.
func _ready():
	$CenterContainer/GridContainer/Mixed.grab_focus()
	var i = 0
	for item in get_node("CenterContainer/GridContainer").get_children():
		if ((avail_endings >> i) % 2) == 1:
			item.disabled = false
		else:
			item.disabled = true
			
		i += 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Mixed_pressed():
	AudioManager.play_sfx(blip)
	
	var sprite = $MixedEnding
	if sprite.is_visible():
		sprite.set_visible(false)
	else:
		sprite.set_visible(true)

func _on_Necronomicon_pressed():
	AudioManager.play_sfx(blip)
	
	var sprite = $CthuluEnding
	if sprite.is_visible():
		sprite.set_visible(false)
	else:
		sprite.set_visible(true)

func _on_Wood_pressed():
	AudioManager.play_sfx(blip)
	
	var sprite = $WinchesterEnding
	if sprite.is_visible():
		sprite.set_visible(false)
	else:
		sprite.set_visible(true)


func _on_Bat_pressed():
	AudioManager.play_sfx(blip)
	
	var sprite = $VampireAlternateEnding
	if sprite.is_visible():
		sprite.set_visible(false)
	else:
		sprite.set_visible(true)

func _on_Pickaxe_pressed():
	AudioManager.play_sfx(blip)
	
	var sprite = $DwarfEnding
	if sprite.is_visible():
		sprite.set_visible(false)
	else:
		sprite.set_visible(true)

func _on_Rock_pressed():
	AudioManager.play_sfx(blip)
	
	var sprite = $DragonEnding
	if sprite.is_visible():
		sprite.set_visible(false)
	else:
		sprite.set_visible(true)

func _on_Sinalizer_pressed():
	AudioManager.play_sfx(blip)
	
	var sprite = $AliensEnding
	if sprite.is_visible():
		sprite.set_visible(false)
	else:
		sprite.set_visible(true)

func _on_Hat_pressed():
	AudioManager.play_sfx(blip)
	
	var sprite = $WizardEnding
	if sprite.is_visible():
		sprite.set_visible(false)
	else:
		sprite.set_visible(true)

func _on_Leaf_pressed():
	AudioManager.play_sfx(blip)
	
	var sprite = $YggdrasilEnding
	if sprite.is_visible():
		sprite.set_visible(false)
	else:
		sprite.set_visible(true)

func _on_Movie_pressed():
	AudioManager.play_sfx(blip)
	
	var sprite = $RealityShowEnding
	if sprite.is_visible():
		sprite.set_visible(false)
	else:
		sprite.set_visible(true)

func _on_Return_pressed():
	AudioManager.play_sfx(back_bweep)
	
	get_parent().menu_sel = 1
	self.queue_free()
