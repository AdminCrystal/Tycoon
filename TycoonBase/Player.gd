extends KinematicBody

var gravity = -9.8
var velocity = Vector3()
var camera
const SPEED = 6
const ACCELERATION = 3
const DE_ACCELERATION = 5




# Called when the node enters the scene tree for the first time.
func _ready():
	camera = $CameraBase/Camera.get_global_transform()
	Menu.visible = false
	ControlsMenu.visible = false
	

func _input(event):
	if event.is_action_pressed("rightClick"):
		var location = event.position
		$CameraBase.rotate_y(5)
		print("yuh")
		
	if event.is_action_pressed("k"):
		print("1")
	if event.is_action_pressed("a"):
		print("2")
	if event.is_action_pressed("j"):
		print("3")
	if event.is_action_pressed("delete"):
		print("4")
		
	

func _unhandled_key_input(event):
	if event.is_action_pressed("menu"):
		Menu.visible = !Menu.visible
		ControlsMenu.visible = false
		
		

func _physics_process(delta):
	var dir = Vector3()
	if Input.is_action_pressed("moveForward"):
		dir += -camera.basis[2]
	if Input.is_action_pressed("moveBackward"):
		dir += camera.basis[2]
	if Input.is_action_pressed("moveLeft"):
		dir += -camera.basis[0]
	if Input.is_action_pressed("moveRight"):
		dir += camera.basis[0]
	
	dir.y = 0
	dir = dir.normalized()
	
	velocity.y += delta * gravity
	var hv = velocity
	hv.y = 0
	
	var new_pos = dir * SPEED
	var accel = DE_ACCELERATION
	
	if (dir.dot(hv) > 0):
		accel = ACCELERATION
	
	hv = hv.linear_interpolate(new_pos, accel * delta)
	
	velocity.x = hv.x
	velocity.z = hv.z
	
	velocity = move_and_slide(velocity, Vector3(0,1,0))
	
	
	
	
