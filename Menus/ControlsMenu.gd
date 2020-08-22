extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_StandardControls_pressed():
	Controls.setControls("standardControls.controls")
	Controls.setPreference("controlsFile", "standardControls.controls")


func _on_DvorakControls_pressed():
	Controls.setControls("dvorakControls.controls")
	Controls.setPreference("controlsFile", "dvorakControls.controls")

func _on_BackButton_pressed():
	Menu.visible = true
	self.visible = false


func _on_CloseMenus_pressed():
	ControlsMenu.visible = false
