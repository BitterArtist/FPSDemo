extends KinematicBody

const UP = Vector3(0,-1,0)
const SPEED = 5.0
const ROTATION_SPEED = 0.05
var mouseSensitivity = 0.05
var joystickSensitivity = 0.05

var rayCast 

func _ready():
	$AudioStreamPlayer.play()
	$AudioStreamPlayer.stream_paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	rayCast = get_node("Camera/RayCast")

func _physics_process(delta):
	#Raycast Hit
	rayCast.force_raycast_update()
	if(rayCast.is_colliding()):
		var collisionBody = rayCast.get_collider()
		if(collisionBody.name == "InteractiveSphere"):
			get_node("../InteractiveSphere").activated = true
		else:
			get_node("../InteractiveSphere").activated = false





	#Movement
	var motion = Vector3()

	if Input.is_action_pressed("ui_up"):
		motion.z += -1.0
	if Input.is_action_pressed("ui_down"):
		motion.z += 1.0
	if Input.is_action_pressed("ui_left"):
		motion.x += -1.0
	if Input.is_action_pressed("ui_right"):
		motion.x += 1.0
	
	#controller look around
	$Camera.rotate_x(Input.get_action_strength("look_up") * joystickSensitivity)
	$Camera.rotate_x(Input.get_action_strength("look_down") * joystickSensitivity * -1)
	if($Camera.rotation_degrees.x < -70):
		$Camera.rotation_degrees.x = -70
	elif($Camera.rotation_degrees.x > 70):
		$Camera.rotation_degrees.x = 70
	rotate_y(Input.get_action_strength("look_left") * joystickSensitivity)
	rotate_y(Input.get_action_strength("look_right") * joystickSensitivity * -1)


	motion = transform.basis * motion.normalized() * SPEED
	if(motion.z != 0):
		$AudioStreamPlayer.stream_paused = false
	else:
		$AudioStreamPlayer.stream_paused = true

	move_and_slide(motion, UP)


func _input(event):
	#mouse look around
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		$Camera.rotate_x(deg2rad(event.relative.y * mouseSensitivity * -1))
		rotate_y(deg2rad(event.relative.x * mouseSensitivity * -1))
		
	#if event is InputEventJoypadMotion:
	#	if event.is_action("joystick_mouse_vertical"):
	#		$Camera.rotate_x(deg2rad(event.axis_value * joystickSensitivity * -1))
	#	if event.is_action("joystick_mouse_horizontal"):
	#		rotate_y(deg2rad(event.axis_value * joystickSensitivity * -1))
