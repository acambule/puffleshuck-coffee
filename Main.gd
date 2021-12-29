extends Node

# X is sides
# Y is up/down
# Z is front/back

onready var Striker = $Striker
onready var WorldCam = $Camera

var is_captured = false
var move_to_pos = Vector3.ZERO


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	if is_captured: 
		Striker.move_and_collide(move_to_pos)

func _input(event):
	if event is InputEventMouseButton && event.pressed:
		is_captured = !is_captured
		print("captured set to: " + String(is_captured))
		if !is_captured: 
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

	if event is InputEventMouseMotion:
		#move_to_pos = Vector3(Striker.translation.x + event.relative.x * 0.01, -Striker.translation.y + event.relative.y * 0.01, Striker.translation.z + event.relative.y * 0.01)
		#move_to_pos = Vector3(event.relative.x * 0.01, event.relative.y * 0.01, event.relative.y * 0.01)
		move_to_pos = Vector3(event.relative.x, event.relative.y, event.relative.y)
		print(move_to_pos)
		#Striker.translation = move_to_pos
