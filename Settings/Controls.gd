extends Node



func _ready():
	#creates default files if they do not exist
	createStandardControls()
	createDvorakControls()
	createPreferences()
	
	#gets players controls and applies them
	var controls = getControls()
	setControls(controls)
	setControls("defaultControls.controls")
	

func _input(event):
	if event.is_action_pressed('chat'):
		print("test worked")
	


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
	
	saveDict.values()	
	
	
	
#recreates a fresh dvorak control when they open the game
func createDvorakControls():
	var saveControls = File.new()
	#if not saveControls.file_exists("user://preferences.settings"):
	saveControls.open("user://dvorakControls.controls", File.WRITE)
	var saveDict = {
		"move_forward": "Comma",
		"move_backward": "o",
		"move_left": "a",
		"move_right": "e",
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
		"chat": "Enter"
		
	}
	saveControls.store_line(to_json(saveDict))
	saveControls.close()	



#recreates fresh standard controls every time they open the game
func createStandardControls():
	var saveControls = File.new()
	#if not saveControls.file_exists("user://preferences.settings"):
	saveControls.open("user://defaultControls.controls", File.WRITE)
	var saveDict = {
		"move_forward": "w",
		"move_backward": "s",
		"move_left": "a",
		"move_right": "d",
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
		"chat": "Enter"
	
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
func setControls(filepath):
	var file = File.new()
	file.open("user://" + filepath, File.READ)
	
	#this resets the InputMap to default meaning
	#that if the controls are changed there will
	#not be multiple keys per InputMap
	InputMap.load_from_globals()
	var control = parse_json(file.get_line()) 
	
	for i in range(control.size()):
		var keyCode = InputEventKey.new()
		keyCode.scancode = OS.find_scancode_from_string(control.values()[i])
		InputMap.add_action(control.keys()[i])
		InputMap.action_add_event(control.keys()[i], keyCode)
		

	file.close()
	
























