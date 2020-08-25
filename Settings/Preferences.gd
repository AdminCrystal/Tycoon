extends Node

var fps_delay = 10



var do_display_fps
var fps_color: Color
var fps_location

var is_music_muted
var is_game_muted
var music_volume
var player_volume
var enemy_volume
var item_volume
var weather_volume

var mouse_sensitivity
var texture_quality
var water_quality
var shadow_quality
var field_of_view

onready var FPSDisplay = $FPSDisplay


func _ready():
	create_preferences()
	get_preferences()
	apply_preferences()


func _physics_process(delta):
	display_fps()
	


func apply_preferences():
	if do_display_fps:
		var fps_display = $FPSDisplay
		fps_display.add_color_override("font_color", fps_color)
		if fps_location[0] == 1:
			fps_display.align = HALIGN_RIGHT
		if fps_location[1] == 1:
			fps_display.valign = VALIGN_BOTTOM


func change_preference(key: String, value: String):
	#gets dictionary data then closes
	var file = File.new()
	file.open("user://preferences.settings", File.READ)
	var data: Dictionary = parse_json(file.get_line())
	file.close()
	
	
	file.open("user://preferences.settings", File.WRITE)
	data[key] = value	
	file.store_line(to_json(data))
	file.close()


func create_preferences():
	var file = File.new()
	file.open("user://preferences.settings", File.WRITE)
	var save_dict = {
		"controls_file": "user://dvorak_controls.controls",
		
		"do_display_fps": true,
		"fps_color": [0,255,0],
		"fps_location": [1, 0],
		
		#music settings
		"is_music_muted": false,
		"is_game_muted": false,
		"music_volume": 50,
		"player_volume": 50,
		"enemy_volume": 50,
		"item_volume": 50,
		"weather_volume": 50,
		
		#player settings
		"mouse_sensitivity": 50,
		"field_of_view": 90,
		
		#graphics settings
		"display_resolution": [1920, 1080],
		"target_fps": 60,
		"texture_quality": "High",
		"water_quality": "High",
		"shadow_quality": "High",
		"anti_aliasing": "Off",
		"vsync": false,
		"tesselation": "Off",
		"ambient_occulsion": "Off",
		"anisotropic_filtering": "Off",
		"hdr": false,
		"bloom": false,
		"motion_blur": false,
		
			
	}
	file.store_line(to_json(save_dict))
	file.close()
	save_dict.clear()


func display_fps():
	if do_display_fps:
		#fps_delay is a performance boost
		fps_delay -= 1
		if fps_delay == 0:
			FPSDisplay.text = str(Engine.get_frames_per_second())
			fps_delay = 10
		

func get_preferences():
	var file = File.new()
	if not file.file_exists("user://preferences.settings"):
		create_preferences()
	file.open("user://preferences.settings", File.READ)
	var data = parse_json(file.get_line())
	
	do_display_fps = data.do_display_fps
	fps_color = Color(data.fps_color[0], data.fps_color[1], data.fps_color[2])
	fps_location = data.fps_location
	
	is_music_muted = data.is_music_muted
	is_game_muted = data.is_game_muted
	music_volume = data.music_volume
	player_volume = data.player_volume
	enemy_volume = data.enemy_volume
	item_volume = data.item_volume
	weather_volume = data.weather_volume
	
	mouse_sensitivity = data.mouse_sensitivity
	texture_quality = data.texture_quality
	water_quality = data.water_quality
	shadow_quality = data.shadow_quality
	field_of_view = data.field_of_view

