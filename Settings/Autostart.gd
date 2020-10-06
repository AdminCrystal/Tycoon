extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Preferences.create_preferences()
	Preferences.get_preferences()
	Preferences.apply_preferences()
	
	Controls.create_standard_controls()
	Controls.create_dvorak_controls()
	Controls.set_controls(Controls.get_controls())
	

func _physics_process(_delta: float) -> void:
	Preferences.display_fps()


func _unhandled_key_input(event: InputEventKey) -> void:
	if event.is_action_pressed("open_menu"):
		if Menu.visible == false and SettingsMenu.visible == false:
			Menu.visible = true
		else:
			Menu.visible = false
			SettingsMenu.visible = false
			SettingsMenu.accepting_input = false
			SettingsMenu.save_preferences()

