extends Control





# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass




func _on_ChangeControls_pressed():
	Menu.visible = false
	ControlsMenu.visible = true


func _on_Quit_pressed():
	get_tree().quit()


func _on_CloseMenu_pressed():
	Menu.visible = false
