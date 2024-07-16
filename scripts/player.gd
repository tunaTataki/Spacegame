extends CharacterBody3D

var gravity = 9.81
var low_gravity = 2.0
var max_speed = 5
var accel = 0.1
var sensitivity = 0.005

var input_vector
var direction

var timer
var timer_for_rotation

var mouse_movement_relative

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	timer = Timer.new()
	timer.autostart = true
	timer.one_shot = false
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)
	timer.start(3)
	
	timer_for_rotation = Timer.new()
	timer_for_rotation.autostart = true
	timer.one_shot = true
	timer.timeout.connect(_on_timer_for_rotation_timeout)
	add_child(timer_for_rotation)
	timer_for_rotation.start(4.5)
	
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		mouse_movement_relative = event.relative
		
		$HeadPivot.rotate_y(-event.relative.x * sensitivity)
		$HeadPivot/Camera3D.rotate_x(-event.relative.y * sensitivity)
		
		$HeadPivot/Camera3D.rotation.x = clamp($HeadPivot/Camera3D.rotation.x, deg_to_rad(-40), deg_to_rad(60))

#func _input(event):
#	match 

func _physics_process(_delta):
	#if not is_on_floor():
	#	velocity.y = velocity.y - gravity * _delta
	
	#if Input.is_action_just_pressed("jump") and is_on_floor():
	#	velocity.y = 4.5
	
	input_vector = Input.get_vector("strafe_left", "strafe_right", "forward", "backward")
	direction = ($HeadPivot.transform.basis * Vector3(input_vector.x, 0, input_vector.y)).normalized()
	direction = ($HeadPivot/Camera3D.transform.basis * direction).normalized()
	if direction:
		if velocity.x <= max_speed:
			velocity.x += direction.x * accel
		if velocity.z <= max_speed:
			velocity.z += direction.z * accel
		if velocity.y <= max_speed:
			velocity.y += direction.y * accel
	
	move_and_slide()

func _on_timer_timeout():
	print("input_vector")
	print(input_vector)
	print()
	
	print("direction")
	print(direction)
	print()
	
	print("HeadPivot's basis")
	print($HeadPivot.transform.basis)
	print()
	
	#print("InputEventMouseMovement.relative - ")
	#print(mouse_movement_relative)
	#print()
	
	print("----------------")
	print()

func _on_timer_for_rotation_timeout():
	$HeadPivot.rotate_y(1.5707963268)
