extends Node

# X is sides
# Y is up/down
# Z is front/back

onready var Striker = $Striker
onready var WorldCam = $Camera

var is_captured


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	is_captured = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func _input(event):
	if event is InputEventMouseButton && event.pressed:
		is_captured = !is_captured
		print("captured set to: " + String(is_captured))
		if !is_captured: 
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

	if event is InputEventMouseMotion && is_captured:
		#var mouse_pos = get_viewport().get_mouse_position()
		print(event.relative)
		Striker.translation = Vector3(Striker.translation.x + event.relative.x * 0.01, -Striker.translation.y + event.relative.y * 0.01, Striker.translation.z + event.relative.y * 0.01)
		



#func get_key_input(delta):
#	velocity.x = 0
#	velocity.z = 0 
#	velocity.y = 0
#
#	if Input.is_action_pressed("move_foreward"):
#		velocity.z -= speed * delta
#		velocity.y -= speed * delta
#		print("pressed move_foreward!")
#		print("  front/back z:" + String(velocity.z))
#		print("  up/down y:" + String(velocity.y))
#
#	if Input.is_action_pressed("move_back"):
#		velocity.z += speed * delta
#		velocity.y -= speed * delta
#		print("pressed move_back!")
#		print("  front/back z:" + String(velocity.z))
#		print("  up/down y:" + String(velocity.y))
#
#	if Input.is_action_pressed("move_left"):
#		velocity.x -= speed * delta
#		print("pressed move_left!")
#		print("  left x:" + String(velocity.x))
#
#	if Input.is_action_pressed("move_right"):
#		velocity.x += speed * delta
#		print("pressed move_right!")
#		print("  right x:" + String(velocity.x))
#
#func move_striker_by_mouse_old(delta):
#	# Get the camera (just an example)	
#	var mouse_pos = get_viewport().get_mouse_position()
#
#	# Project mouse into a 3D ray
#	var ray_origin = WorldCam.project_ray_origin(mouse_pos)
#	var ray_direction = WorldCam.project_ray_normal(mouse_pos)
#
#	# Cast a ray
#	var from = ray_origin
#	var to = ray_origin + ray_direction * 1000.0
#	var space_state = Striker.get_world().get_direct_space_state()
#	var hit = space_state.intersect_ray(from, to)
#	if hit.size() != 0:
#		# collider will be the node you hit		
#		if hit.collider == Striker and Input.is_mouse_button_pressed(BUTTON_LEFT):
#			print("hit and pressed")
#			#var mouse_pos3 = Vector3(mouse_pos.x,  Striker.global_transform.origin.y, mouse_pos.y)
#			#Striker.move_and_collide(mouse_pos3)
