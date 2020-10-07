extends Control

# determines whether this control should accept input
var accepting_input: bool = false
# the user supplied key to change control
var new_key: String = ''
# provides current controls button to change
var current_button: Button
# checks if any preferences were changed
var were_preferences_changed: bool = false


func _ready() -> void:
	self.visible = false
	update_all_controls_display()
	update_all_sounds_display()
	connect_all_buttons()
	
	were_preferences_changed = false


func _input(event: InputEvent) -> void:
	# gets user input and applys it to new_key
	if accepting_input:
		if event is InputEventKey:
			new_key = event.as_text()
			($ButtonChanger/Label as Label).text += new_key.to_lower()
			accepting_input = false
			get_tree().set_input_as_handled()
		

func connect_all_buttons() -> void:
	# connects control buttons
	for child in $VBoxContainer/SettingsRow/ControlsScroller/ControlsContainer/Controls.get_children():
		child.connect('pressed', self, 'update_control', [child])
		
	# conects sound buttons
	for child in $VBoxContainer/SettingsRow/SoundScroller/SoundContainer/Sounds.get_children():
		child.connect('value_changed', self, 'update_sound_display', [child])
		
	connect_graphics_buttons()


func connect_graphics_buttons():
	var container = $VBoxContainer/SettingsRow/GraphicsScroller/GraphicsContainer/Graphics
	
	var window_type_options = container.get_child(0)
	var resolution_options = container.get_child(1)
	var msaa_options = container.get_child(2)
	var vsync_options = container.get_child(3)
	var max_fps_options = container.get_child(4)
	var display_fps_options = container.get_child(5)
	var fps_location_options = container.get_child(6)
	var fps_color_options = container.get_child(7)
	
	for child in window_type_options.get_children():
		child = child as Button
		if child.get_name() == Preferences.data["window_type"]:
			child.disabled = true
		child.connect('pressed', self, 'change_window_size', [child])
		
	for child in resolution_options.get_children():
		child = child as Button
		if child.get_name() == Preferences.data["resolution"]:
			child.disabled = true
		child.connect('pressed', self, 'change_resolution', [child])
		

func change_resolution(resolution: Button) -> void:
	var name: String = resolution.get_name()
	Preferences.data['resolution'] = name
	for child in resolution.get_parent().get_children():
		if child.get_name() == name:
			child.disabled = true
		else:
			child.disabled = false
	Preferences.adjust_screen_resolution()
	were_preferences_changed = true
	
	
func change_window_size(window_type: Button) -> void:
	var name: String = window_type.get_name()
	Preferences.data["window_type"] = name
	for child in window_type.get_parent().get_children():
		if child.get_name() == name:
			child.disabled = true
		else:
			child.disabled = false
	Preferences.adjust_screen_size()
	were_preferences_changed = true
	
	
func update_all_controls_display() -> void:
	for child in $VBoxContainer/SettingsRow/ControlsScroller/ControlsContainer/Controls.get_children():
		update_control_display(child)


func update_control_display(button: Button) -> void:
	# gets the saved controls and puts that as the text
	button.text = Controls.controls[button.get_name()].to_lower()
	

func update_control(button: Button) -> void:
	current_button = button
	($ButtonChanger as TextureRect).visible = true
	accepting_input = true
	
	
func update_all_sounds_display() -> void:
	for child in $VBoxContainer/SettingsRow/SoundScroller/SoundContainer/Sounds.get_children():
		child = (child as HScrollBar)
		update_sound_display(Preferences.data[child.get_name()], child)
		child.value = Preferences.data[child.get_name()]
		


func update_sound_display(value: float, scroller: HScrollBar) -> void:
	var label: Label = scroller.get_child(0)
	label.text = str(value)
	were_preferences_changed = true
	var key: String = scroller.get_name()
	var other_key: String = key.substr(0, -10)
	Preferences.data[key] = value
	Preferences.data[other_key] = Preferences.calculate_volume(Preferences.data[key])
	

func _on_StandardControls_pressed() -> void:
	var controls_file = "user://standard_controls.controls"
	Controls.set_controls(controls_file)
	Preferences.data.controls_file = controls_file
	were_preferences_changed = true
	update_all_controls_display()


func _on_DvorakControls_pressed() -> void:
	var controls_file = "user://dvorak_controls.controls"
	Controls.set_controls(controls_file)
	Preferences.data.controls_file = controls_file
	were_preferences_changed = true
	update_all_controls_display()


func _on_BackButton_pressed() -> void:
	self.visible = false
	Menu.visible = true
	($ButtonChanger as TextureRect).visible = false
	accepting_input = false
	save_preferences()


func _on_CloseMenus_pressed() -> void:
	self.visible = false
	($ButtonChanger as TextureRect).visible = false
	accepting_input = false
	save_preferences()


func _on_Confirm_pressed():
	($ButtonChanger as TextureRect).visible = false
	if !accepting_input:
		were_preferences_changed = true
		var controls_file: String = "user://custom_controls.controls"
		Controls.change_control(current_button.get_name(), new_key, controls_file)
		Controls.set_controls(controls_file)
		update_control_display(current_button)
		($ButtonChanger/Label as Label).text = "Push Button\n"
	accepting_input = false


func _on_Cancel_pressed():
	($ButtonChanger as TextureRect).visible = false
	($ButtonChanger/Label as Label).text = "Push Button\n"
	accepting_input = false


func _on_CustomControls_pressed():
	var controls_file = "user://custom_controls.controls"
	Controls.set_controls("user://custom_controls.controls")
	Preferences.data.controls_file = controls_file
	update_all_controls_display()
	were_preferences_changed = true


func save_preferences():
	# will update preferences file if changes were made
	if were_preferences_changed:
		Preferences.save_preferences()
		were_preferences_changed = false



func _on_Controls_pressed():
	$VBoxContainer/SettingsRow/GraphicsScroller.visible = false
	$VBoxContainer/SettingsRow/SoundScroller.visible = false
	$VBoxContainer/SettingsRow/ControlsScroller.visible = true
	display_preset_children(true)


func _on_Sound_pressed():
	$VBoxContainer/SettingsRow/GraphicsScroller.visible = false
	$VBoxContainer/SettingsRow/ControlsScroller.visible = false
	$VBoxContainer/SettingsRow/SoundScroller.visible = true
	display_preset_children(false)


func display_preset_children(visible: bool) -> void:
	for child in $VBoxContainer/PresetsRow.get_children():
		child.visible = visible


func _on_Graphics_pressed() -> void:
	$VBoxContainer/SettingsRow/ControlsScroller.visible = false
	$VBoxContainer/SettingsRow/SoundScroller.visible = false
	$VBoxContainer/SettingsRow/GraphicsScroller.visible = true
	display_preset_children(false)

	
