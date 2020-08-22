extends Node



func _ready():
	#creates default controls every time game is opened
	#aka a failsafe for people editing the files 
	createStandardControls()
	createDvorakControls()
	
	
	#gets players controls and applies them
	var controls = getControls()
	setControls(controls)
	
	


func createCustom1():
	pass
	
	
	
func createCustom2():
	pass
	
	
	
func createCustom3():
	pass	
	
	
	
func createPreferences():
	var preferences = File.new()
	preferences.open("user://preferences.settings", File.WRITE)
	var saveDict = {
		"filename" : "preferences",
		"controlsFile": "user://dvorakControls.controls"
		
	}
	preferences.store_line(to_json(saveDict))
	preferences.close()
	
	


func changePreference(key: String, value: String):
	#gets dictionary data then closes
	var preferences = File.new()
	preferences.open("user://preferences.settings", File.READ)
	var data: Dictionary = parse_json(preferences.get_line())
	preferences.close()
	
	
	preferences.open("user://preferences.settings", File.WRITE)
	data[key] = value	
	preferences.store_line(to_json(data))
	preferences.close()
	
	

func changeControl(key: String, value: String, controlsFile: String):
	var file: File = File.new()
	var _open
	var controls: Dictionary
	if not file.file_exists(controlsFile):
		_open = file.open("user://preferences.settings", File.READ)
		controls = parse_json(file.get_line())
		file.close()
		_open = file.open(controls.controlsFile, File.READ)
		controls = parse_json(file.get_line())
		_open = file.open(controlsFile, File.WRITE)
	else:		
		_open = file.open(controlsFile, File.READ)
		controls = parse_json(file.get_line())
	file.close()
	controls[key] = value
	_open = file.open(controlsFile, File.WRITE)
	file.store_line(to_json(controls))
	file.close()
	controls.clear()
	
	



#recreates a fresh dvorak control when they open the game
func createDvorakControls():
	var saveControls = File.new()
	#if not saveControls.file_exists("user://preferences.settings"):
	saveControls.open("user://dvorakControls.controls", File.WRITE)
	var saveDict = {
		#Defaults
		"moveForward": "Comma",
		"moveLeft": "a",
		"moveBackward": "o",
		"moveRight": "e",
		"jump": "Space",
		"menu": "Escape",
		"interact": "Period",
		
		"upArrow": "Up",
		"leftArrow": "Left",
		"downArrow": "Down",
		"rightArrow": "Right",
		#End Defaults
		
	
		
		#Mouse actions
		"leftClick": "LeftClick",
		"rightClick": "RightClick",
		"scrollUp": "ScrollWheelUp",
		"scrollDown": "ScrollWheelDown",
		"scrollLeft": "ScrollWheelLeft",
		"scrollRight": "ScrollWheelRight",
		#End Mouse Actions
		


		#Row 0 (function keys)
		"f1": "F1",
		"f2": "F2",
		"f3": "F3",
		"f4": "F4",
		"f5": "F5",
		"f6": "F6",
		"f7": "F7",
		#WARNING
		#f8 closes editor
		"f8": "F8",
		"f9": "F9",
		"f10": "F10",
		"f11": "F11",
		"f12": "F12",
		"insert": "Insert",
		"delete": "Delete",
		#End Row 0 (function keys)



		#WARNING 
		#MISSING TILDE
		#Row 1
		"hotbar1": "1",
		"hotbar2": "2",
		"hotbar3": "3",
		"hotbar4": "4",
		"hotbar5": "5",
		"hotbar6": "6",
		"hotbar7": "7",
		"hotbar8": "8",
		"hotbar9": "9",
		"hotbar0": "0",
		"minus": "BraceLeft",
		"equals": "BraceRight",
		"backSpace": "BackSpace",
		#End Row 1
		
		
		
		#Row 2
		"tab": "Tab",
		"q": "Apostrophe",
		"w": "Comma",
		"e": "Period",
		"r": "p",
		"t": "y",
		"y": "f",
		"u": "g",
		"i": "c",
		"o": "r",
		"p": "l",
		"leftBrace": "Slash",
		"rightBrace": "Equal",
		"backSlash": "BackSlash",
		#End Row 2
		
		
		
		#Row 3
		"capsLock": "Capslock",
		"a": "a",
		"s": "o",
		"d": "e",
		"f": "u",
		"g": "i",
		"h": "d",
		"j": "h",
		"k": "t",
		"l": "n",
		"semiColon": "s",
		"apostrophe": "Minus",
		"enter": "Enter",
		#End Row 3
		
		
		
		#Row 4
		"shift": "Shift",
		"z": "SemiColon",
		"x": "q",
		"c": "j",
		"v": "k",
		"b": "x",
		"n": "b",
		"m": "m",
		"comma": "w",
		"period": "v",
		"forwardSlash": "z",
		#End Row 4
		
		
		
		#Row 5
		"ctrl": "Control",
		"alt": "Alt",
		"space": "Space",
		#End Row 5
		
		
		
		#Special keys (right side of keyboard)
		"home": "Home",
		#WARNING
		#Print screen input might be undetectable for users
		#"printScreen": "Print",
		"volumeMute": "VolumeMute",
		"volumeDown": "VolumeDown",
		"volumeUp": "VolumeUp",
		
		"pageUp": "PageUp",
		#WARNING
		#asterisk and plus may be undetectable
		#"asterisk": "Asterisk",
		#"plus": "Plus",
		
		"pageDown": "PageDown",
		"end": "End",
		
	}
	saveControls.store_line(to_json(saveDict))
	saveControls.close()	
	saveDict.clear()
	
	
	
	

#recreates fresh standard controls every time they open the game
func createStandardControls():
	var saveControls = File.new()
	#if not saveControls.file_exists("user://preferences.settings"):
	saveControls.open("user://standardControls.controls", File.WRITE)
	var saveDict = {
		"moveForward": "w",
		"moveLeft": "a",
		"moveBackward": "s",
		"moveRight": "d",
		"jump": "Space",
		"menu": "Escape",
		"interact": "e",
		
		"upArrow": "Up",
		"leftArrow": "Left",
		"downArrow": "Down",
		"rightArrow": "Right",
		#End Defaults
		
	
		
		#Mouse actions
		"leftClick": "LeftClick",
		"rightClick": "RightClick",
		"scrollUp": "ScrollWheelUp",
		"scrollDown": "ScrollWheelDown",
		"scrollLeft": "ScrollWheelLeft",
		"scrollRight": "ScrollWheelRight",
		#End Mouse Actions
		


		#Row 0 (function keys)
		"f1": "F1",
		"f2": "F2",
		"f3": "F3",
		"f4": "F4",
		"f5": "F5",
		"f6": "F6",
		"f7": "F7",
		#WARNING
		#f8 closes editor
		"f8": "F8",
		"f9": "F9",
		"f10": "F10",
		"f11": "F11",
		"f12": "F12",
		"insert": "Insert",
		"delete": "Delete",
		#End Row 0 (function keys)



		#WARNING 
		#MISSING TILDE
		#Row 1
		"hotbar1": "1",
		"hotbar2": "2",
		"hotbar3": "3",
		"hotbar4": "4",
		"hotbar5": "5",
		"hotbar6": "6",
		"hotbar7": "7",
		"hotbar8": "8",
		"hotbar9": "9",
		"hotbar0": "0",
		"minus": "Minus",
		"equals": "Equal",
		"backSpace": "BackSpace",
		#End Row 1
		
		
		
		#Row 2
		"tab": "Tab",
		"q": "q",
		"w": "w",
		"e": "e",
		"r": "r",
		"t": "t",
		"y": "y",
		"u": "u",
		"i": "i",
		"o": "o",
		"p": "p",
		"leftBrace": "LeftBrace",
		"rightBrace": "RightBrace",
		"backSlash": "BackSlash",
		#End Row 2
		
		
		
		#Row 3
		"capsLock": "Capslock",
		"a": "a",
		"s": "s",
		"d": "d",
		"f": "f",
		"g": "g",
		"h": "h",
		"j": "j",
		"k": "k",
		"l": "l",
		"semiColon": "SemiColon",
		"apostrophe": "Apostrophe",
		"enter": "Enter",
		#End Row 3
		
		
		
		#Row 4
		"shift": "Shift",
		"z": "z",
		"x": "x",
		"c": "c",
		"v": "v",
		"b": "b",
		"n": "n",
		"m": "m",
		"comma": "Comma",
		"period": "Period",
		"forwardSlash": "Slash",
		#End Row 4
		
		
		
		#Row 5
		"ctrl": "Control",
		"alt": "Alt",
		"space": "Space",
		#End Row 5
		
		
		
		#Special keys (right side of keyboard)
		"home": "Home",
		#WARNING
		#Print screen input might be undetectable for users
		#"printScreen": "Print",
		"volumeMute": "VolumeMute",
		"volumeDown": "VolumeDown",
		"volumeUp": "VolumeUp",
		
		"pageUp": "PageUp",
		#WARNING
		#asterisk and plus may be undetectable
		#"asterisk": "Asterisk",
		#"plus": "Plus",
		
		"pageDown": "PageDown",
		"end": "End",
		
		
	}
	saveControls.store_line(to_json(saveDict))
	saveControls.close()
	saveDict.clear()
	


#gets which control file holds their controls
func getControls() -> String:
	var controls = File.new()
	#checks to make sure if file exists and if it
	#doesnt creates a new one, theoretically 'impossible'
	if not controls.file_exists("user://preferences.settings"):
		createPreferences()
	controls.open("user://preferences.settings", File.READ)
	var data = parse_json(controls.get_line())
	
	var location = data.controlsFile
	controls.close()
	return location



#changes the controls to the users preferred
func setControls(filepath: String):
	var file = File.new()
	file.open(filepath, File.READ)
	
	#this resets the InputMap to default meaning
	#that if the controls are changed there will
	#not be multiple keys per InputMap
	InputMap.load_from_globals()
	var control = parse_json(file.get_line()) 
	
	for i in range(control.size()):
		var keyCode = InputEventKey.new()
		keyCode.scancode = OS.find_scancode_from_string(control.values()[i])
		#checks to see if it is a button click or a keycode
		
		
		#WARNING
		#match in gdscript is the same speed as if elif
		#Checks if there is an error code (aka mouse buttons)
		if keyCode.scancode != 0:
			pass
		else:
			match control.values()[i]:
				"LeftClick": 
					keyCode = InputEventMouseButton.new()
					keyCode.button_index = BUTTON_LEFT
				"RightClick":
					keyCode = InputEventMouseButton.new()
					keyCode.button_index = BUTTON_RIGHT
				"MiddleClick":
					keyCode = InputEventMouseButton.new()
					keyCode.button_index = BUTTON_MIDDLE
				"ScrollWheelUp":
					keyCode = InputEventMouseButton.new()
					keyCode.button_index = BUTTON_WHEEL_UP
				"ScrollWheelDown":
					keyCode = InputEventMouseButton.new()
					keyCode.button_index = BUTTON_WHEEL_DOWN
				"ScrollWheelLeft":
					keyCode = InputEventMouseButton.new()
					keyCode.button_index = BUTTON_WHEEL_LEFT
				"ScrollWheelRight":
					keyCode = InputEventMouseButton.new()
					keyCode.button_index = BUTTON_WHEEL_RIGHT
				_:	
					print("Error on control creation key = " + control.values()[i])
				
				
		InputMap.add_action(control.keys()[i])
		InputMap.action_add_event(control.keys()[i], keyCode)
		
	
	file.close()
	
	























