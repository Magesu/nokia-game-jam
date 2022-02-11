extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
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
	var sprite = $MixedEnding
	if sprite.is_visible():
		sprite.set_visible(false)
	else:
		sprite.set_visible(true)

func _on_Necronomicon_pressed():
	var sprite = $CthuluEnding
	if sprite.is_visible():
		sprite.set_visible(false)
	else:
		sprite.set_visible(true)

func _on_Wood_pressed():
	var sprite = $WinchesterEnding
	if sprite.is_visible():
		sprite.set_visible(false)
	else:
		sprite.set_visible(true)


func _on_Bat_pressed():
	var sprite = $VampireAlternateEnding
	if sprite.is_visible():
		sprite.set_visible(false)
	else:
		sprite.set_visible(true)

func _on_Pickaxe_pressed():
	var sprite = $DwarfEnding
	if sprite.is_visible():
		sprite.set_visible(false)
	else:
		sprite.set_visible(true)

func _on_Rock_pressed():
	var sprite = $DragonEnding
	if sprite.is_visible():
		sprite.set_visible(false)
	else:
		sprite.set_visible(true)

func _on_Sinalizer_pressed():
	var sprite = $AliensEnding
	if sprite.is_visible():
		sprite.set_visible(false)
	else:
		sprite.set_visible(true)

func _on_Hat_pressed():
	var sprite = $WizardEnding
	if sprite.is_visible():
		sprite.set_visible(false)
	else:
		sprite.set_visible(true)

func _on_Leaf_pressed():
	var sprite = $YggdrasilEnding
	if sprite.is_visible():
		sprite.set_visible(false)
	else:
		sprite.set_visible(true)

func _on_Movie_pressed():
	var sprite = $RealityShowEnding
	if sprite.is_visible():
		sprite.set_visible(false)
	else:
		sprite.set_visible(true)

func _on_Return_pressed():
	get_parent().menu_sel = 1
	self.queue_free()
