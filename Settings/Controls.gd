extends Node



func _ready():
	#creates default controls every time game is opened
	#aka a failsafe for people editing the files 
	createStandardControls()
	createDvorakControls()
	
	#WARNING
	#need to create a fail safe for preferences file
	#encrypting prevents direct manipulation but if they save
	#a change to the file it could cause crash, or no controls
	#need to create a hash of the file and compare it to see if its modified
	#if modified it should create a new file
	#createPreferences()
	
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
		"controlsFile": "dvorakControls.controls"
		
	}
	preferences.store_line(to_json(saveDict))
	preferences.close()
	
	


func setPreference(key: String, value: String):
	#gets dictionary data then closes
	var preferences = File.new()
	preferences.open("user://preferences.settings", File.READ)
	var data: Dictionary = parse_json(preferences.get_line())
	preferences.close()
	
	
	preferences.open("user://preferences.settings", File.WRITE)
	data[key] = value	
	preferences.store_line(to_json(data))
	preferences.close()
	
	


#recreates a fresh dvorak control when they open the game
func createDvorakControls():
	var saveControls = File.new()
	#if not saveControls.file_exists("user://preferences.settings"):
	saveControls.open("user://dvorakControls.controls", File.WRITE)
	var saveDict = {
		"moveForward": "Comma",
		"moveLeft": "a",
		"moveBackward": "o",
		"moveRight": "e",
		"jump": "Space",
		"menu": "Escape",
		"hotbar0": "0",
		"hotbar1": "1",
		"hotbar2": "2",
		"hotbar3": "3",
		"hotbar4": "4",
		"hotbar5": "5",
		"hotbar6": "6",
		"hotbar7": "7",
		"hotbar8": "8",
		"hotbar9": "9",
		"chat": "Enter",
		"interact": "Period",
		"shift": "Shift",
		"tab": "Tab",
		"capsLock": "Capslock",
		"backSpace": "BackSpace",
		"backSlash": "BackSlash",
		
				
		"upArrow": "Up",
		"leftArrow": "Left",
		"downArrow": "Down",
		"rightArrow": "Right",
		
		
		
		
		
		"attack": "leftClick",
		"panAround": "rightClick",
		"scrollUp": "scrollWheelUp",
		"scrollDown": "scrollWheelDown",
		"scrollLeft": "scrollWheelLeft",
		"scrollRight": "scrollWheelRight"
		
		
		#FUTURE IMPLEMENTATIONS
#		"minus": "BraceLeft",
#		"equals": "BraceRight",
#		"leftBrace": "ForwardSlash",
#		"rightBrace": "Equal",
#		"semiColon": "s",
#		"forwardSlash": "z",


#		"period": "v",
#		"comma": "w",
		
		
		
		
		
		
	}
	saveControls.store_line(to_json(saveDict))
	saveControls.close()	
	
	
	
	

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
		"hotbar0": "0",
		"hotbar1": "1",
		"hotbar2": "2",
		"hotbar3": "3",
		"hotbar4": "4",
		"hotbar5": "5",
		"hotbar6": "6",
		"hotbar7": "7",
		"hotbar8": "8",
		"hotbar9": "9",
		"chat": "Enter",
		"interact": "e",
		"attack": "leftClick",
		"panAround": "rightClick",
		"shift": "Shift",
		"tab": "Tab",
		"capsLock": "Capslock",
		"backSpace": "BackSpace",
		"backSlash": "BackSlash",		
		
		"upArrow": "Up",
		"leftArrow": "Left",
		"downArrow": "Down",
		"rightArrow": "Right",
		
		
		"scrollUp": "scrollWheelUp",
		"scrollDown": "scrollWheelDown",
		"scrollLeft": "scrollWheelLeft",
		"scrollRight": "scrollWheelRight"
		
		
		
		#FUTURE IMPLEMENTATIONS
#		"minus": "Minus",
#		"equals": "Equal",
#		"leftBrace": "BraceLeft",
#		"rightBrace": "BraceRight",
#		"semiColon": "SemiColon",
#		"forwardSlash": "ForwardSlash",
		
		
	}
	saveControls.store_line(to_json(saveDict))
	saveControls.close()



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
	file.open("user://" + filepath, File.READ)
	
	#this resets the InputMap to default meaning
	#that if the controls are changed there will
	#not be multiple keys per InputMap
	InputMap.load_from_globals()
	var control = parse_json(file.get_line()) 
	
	for i in range(control.size()):
		var keyCode
		#checks to see if it is a button click or a keycode
		
		
		#WARNING
		#match in gdscript is the same speed as if elif
		match control.values()[i]:
			"leftClick": 
				keyCode = InputEventMouseButton.new()
				keyCode.button_index = BUTTON_LEFT
			"rightClick":
				keyCode = InputEventMouseButton.new()
				keyCode.button_index = BUTTON_RIGHT
			"middleClick":
				keyCode = InputEventMouseButton.new()
				keyCode.button_index = BUTTON_MIDDLE
			"scrollWheelUp":
				keyCode = InputEventMouseButton.new()
				keyCode.button_index = BUTTON_WHEEL_UP
			"scrollWheelDown":
				keyCode = InputEventMouseButton.new()
				keyCode.button_index = BUTTON_WHEEL_DOWN
			"scrollWheelLeft":
				keyCode = InputEventMouseButton.new()
				keyCode.button_index = BUTTON_WHEEL_LEFT
			"scrollWheelRight":
				keyCode = InputEventMouseButton.new()
				keyCode.button_index = BUTTON_WHEEL_RIGHT
			_:	
				keyCode = InputEventKey.new()
				keyCode.scancode = OS.find_scancode_from_string(control.values()[i])
				
		InputMap.add_action(control.keys()[i])
		InputMap.action_add_event(control.keys()[i], keyCode)
		

	file.close()
	
	























