extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Preferences.create_preferences()
	Preferences.get_preferences()
	Preferences.apply_preferences()

	Controls.create_standard_controls()
	Controls.create_dvorak_controls()
	Controls.set_controls(Controls.get_controls())


func _physics_process(delta):
	Preferences.display_fps()
