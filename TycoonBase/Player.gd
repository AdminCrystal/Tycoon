extends KinematicBody

var gravity = -9.8
var velocity = Vector3()
var camera
const SPEED = 6
const ACCELERATION = 3
const DE_ACCELERATION = 5




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	camera = $CameraBase/Camera.get_global_transform()
	

func _input(event) -> void:
	if event.is_action_pressed("right_click"):
		var location = event.position
		$CameraBase.rotate_y(5)
		

func _physics_process(delta):
	var dir = Vector3()
	if Input.is_action_pressed("move_forward"):
		dir += -camera.basis[2]
	if Input.is_action_pressed("move_backward"):
		dir += camera.basis[2]
	if Input.is_action_pressed("move_left"):
		dir += -camera.basis[0]
	if Input.is_action_pressed("move_right"):
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
	
	
	
	
