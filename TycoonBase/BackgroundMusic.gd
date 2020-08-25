extends AudioStreamPlayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	update_volume()


func update_volume():
	if !Preferences.is_game_muted and !Preferences.is_music_muted:
		volume_db = Preferences.music_volume
		print(volume_db)
		playing = true
