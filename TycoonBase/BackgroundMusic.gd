extends AudioStreamPlayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	update_volume()


func update_volume():
	if !Preferences.data.is_game_muted and !Preferences.data.is_music_muted:
		Preferences.data.volume_db = Preferences.data.music_volume
		self.playing = true
