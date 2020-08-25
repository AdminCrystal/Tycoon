extends Control





# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_StandardControls_pressed():
	Controls.set_controls("user://standardControls.controls")
	Controls.change_preference("controls_file", "user://standardControls.controls")


func _on_DvorakControls_pressed():
	Controls.set_controls("user://dvorakControls.controls")
	Controls.change_preference("controls_file", "user://dvorakControls.controls")

func _on_BackButton_pressed():
	Menu.visible = true
	self.visible = false


func _on_CloseMenus_pressed():
	ControlsMenu.visible = false


func _on_testButton_pressed():
	var controls_file = "user://customControls.controls"
	Controls.change_control("b", "c", controls_file)
	Controls.change_preference("controls_file", controls_file)
