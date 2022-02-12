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
	
	var sprite = $Arts/MixedEnding
	var current_button = $CenterContainer/GridContainer/Mixed
	
	if sprite.is_visible():
		hide_art()
	else:
		show_art(sprite, current_button)

func _on_Necronomicon_pressed():
	AudioManager.play_sfx(blip)
	
	var sprite = $Arts/CthuluEnding
	var current_button = $CenterContainer/GridContainer/Necronomicon
	
	if sprite.is_visible():
		hide_art()
	else:
		show_art(sprite, current_button)

func _on_Wood_pressed():
	AudioManager.play_sfx(blip)
	
	var sprite = $Arts/WinchesterEnding
	var current_button = $CenterContainer/GridContainer/Wood
	
	if sprite.is_visible():
		hide_art()
	else:
		show_art(sprite, current_button)


func _on_Bat_pressed():
	AudioManager.play_sfx(blip)
	
	var sprite = $Arts/VampireAlternateEnding
	var current_button = $CenterContainer/GridContainer/Bat
	
	if sprite.is_visible():
		hide_art()
	else:
		show_art(sprite, current_button)

func _on_Pickaxe_pressed():
	AudioManager.play_sfx(blip)
	
	var sprite = $Arts/DwarfEnding
	var current_button = $CenterContainer/GridContainer/Pickaxe
	
	if sprite.is_visible():
		hide_art()
	else:
		show_art(sprite, current_button)

func _on_Rock_pressed():
	AudioManager.play_sfx(blip)
	
	var sprite = $Arts/DragonEnding
	var current_button = $CenterContainer/GridContainer/Rock
	
	if sprite.is_visible():
		hide_art()
	else:
		show_art(sprite, current_button)

func _on_Sinalizer_pressed():
	AudioManager.play_sfx(blip)
	
	var sprite = $Arts/AliensEnding
	var current_button = $CenterContainer/GridContainer/Sinalizer
	
	if sprite.is_visible():
		hide_art()
	else:
		show_art(sprite, current_button)

func _on_Hat_pressed():
	AudioManager.play_sfx(blip)
	
	var sprite = $Arts/WizardEnding
	var current_button = $CenterContainer/GridContainer/Hat
	
	if sprite.is_visible():
		hide_art()
	else:
		show_art(sprite, current_button)

func _on_Leaf_pressed():
	AudioManager.play_sfx(blip)
	
	var sprite = $Arts/YggdrasilEnding
	var current_button = $CenterContainer/GridContainer/Leaf
	
	if sprite.is_visible():
		hide_art()
	else:
		show_art(sprite, current_button)

func _on_Movie_pressed():
	AudioManager.play_sfx(blip)
	
	var sprite = $Arts/RealityShowEnding
	var current_button = $CenterContainer/GridContainer/Movie
	
	if sprite.is_visible():
		hide_art()
	else:
		show_art(sprite, current_button)

func _on_Return_pressed():
	AudioManager.play_sfx(back_bweep)
	
	get_parent().menu_sel = 1
	self.queue_free()

func show_art(art, current_button):
	var buttons = get_node("CenterContainer/GridContainer").get_children()
	
	art.set_visible(true)
	
	for child in buttons:
		if child.get_index() != current_button.get_index():
			child.focus_mode = FOCUS_NONE

func hide_art():
	var arts = get_node("Arts").get_children()
	var buttons = get_node("CenterContainer/GridContainer").get_children()
	
	for child in arts:
		child.set_visible(false)
	
	for child in buttons:
		child.focus_mode = FOCUS_ALL
