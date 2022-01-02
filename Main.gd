extends Node

# X is sides
# Y is up/down (keep on 0, if it shall stay on bottom of something)
# Z is front/back

const ray_length = 1000

onready var Striker = $Striker
onready var WorldCam = $Camera

export var speed = 1

var last_delta = 0
var is_captured = false
var is_moved = false
var move_to_pos = Vector3.ZERO
var velocity = Vector3.ZERO


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Striker Position: " + str(Striker.translation))
	pass

func _physics_process(delta: float) -> void:
	#get_key_input(delta)
	last_delta = delta
	#if is_captured && is_moved:
	#	Striker.move_and_collide(move_to_pos)
	#	is_moved = false
	
	#Striker.move_and_collide(move_to_pos)
	Striker.translate(move_to_pos)

func __input(event):
	if event is InputEventMouseButton && event.is_action_pressed("mouse_right"):
		Striker.translate(Vector3(0.0,0.5,-0.0))
		return
	if event is InputEventMouseButton && event.pressed:
		is_captured = !is_captured
		print("captured set to: " + String(is_captured))
		if !is_captured: 
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

	if event is InputEventMouseMotion && is_captured:
		var mouse_raycast = get_mouse_raycast()
		if mouse_raycast != null:
			print(str(mouse_raycast))
			#Striker.move_and_collide(move_to_pos)
			#Striker.translate(move_to_pos)

func _input(event):
	if event is InputEventMouseButton && event.pressed:
		is_captured = !is_captured		
		print("captured set to: " + String(is_captured))
		if !is_captured: 
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			var new_mouse_pos = Vector2(Striker.global_transform.origin.x, Striker.global_transform.origin.z)
			Input.warp_mouse_position( new_mouse_pos )
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

	if event is InputEventMouseMotion && is_captured:
		#move_to_pos = Vector3(Striker.translation.x + event.relative.x * 0.01, -Striker.translation.y + event.relative.y * 0.01, Striker.translation.z + event.relative.y * 0.01)
		#move_to_pos = Vector3(event.relative.x * 0.01, event.relative.y * 0.01, event.relative.y * 0.01)		
		#move_to_pos = Vector3(event.relative.x, event.relative.y, event.relative.y)
		
		var x = 0.0
		var y = 0.0
		var z = 0.0
		
		x = Striker.transform.origin.x 
		#y = Striker.transform.origin.y
		#z = Striker.transform.origin.z
		
		#print(str(event.relative))
		#print(str(event.relative.x))
		#print(str(event.relative.y))
		
		# left / right - on 3D - x-axis
		if event.relative.x > 0: 
			x = Striker.transform.origin.x + speed * last_delta
		elif event.relative.x < 0: 
			x = Striker.transform.origin.x - speed * last_delta
		
		# up / down - on 3D - y- and z- axis to maintain perspective
		#if event.relative.y > 0: 
			#y = Striker.transform.origin.y + speed * last_delta
			#z = Striker.transform.origin.z + speed * last_delta
			
		#elif event.relative.y < 0: 
			#y = Striker.transform.origin.y - speed * last_delta
			#z = Striker.transform.origin.z - speed * last_delta

		move_to_pos = Vector3(x, y, z)
		is_moved = true
		
		#print("Event: " + String(event.relative))
		#print("Striker Pos: " + String(Striker.transform.origin))
		print("Move to: " + String(move_to_pos))

func get_key_input(delta):
	velocity.x = 0
	velocity.z = 0 
	velocity.y = 0

	if Input.is_action_pressed("move_foreward"):
		velocity.z -= speed * delta
		velocity.y -= speed * delta
		print("pressed move_foreward!")
		print("  front/back z:" + String(velocity.z))
		print("  up/down y:" + String(velocity.y))

	if Input.is_action_pressed("move_back"):
		velocity.z += speed * delta
		velocity.y -= speed * delta
		print("pressed move_back!")
		print("  front/back z:" + String(velocity.z))
		print("  up/down y:" + String(velocity.y))

	if Input.is_action_pressed("move_left"):
		velocity.x -= speed * delta
		print("pressed move_left!")
		print("  left x:" + String(velocity.x))

	if Input.is_action_pressed("move_right"):
		velocity.x += speed * delta
		print("pressed move_right!")
		print("  right x:" + String(velocity.x))

func get_mouse_raycast():
	# Vector2 - mouse position
	var mouse_pos = get_viewport().get_mouse_position()
	
	var space_state = Striker.get_world().get_direct_space_state()
	
	var from = WorldCam.project_ray_origin(mouse_pos)	
	var to = from + WorldCam.project_ray_normal(mouse_pos) * ray_length
	
	var results = space_state.intersect_ray(from, to)
	if results.size() > 0:
		return results["position"]
