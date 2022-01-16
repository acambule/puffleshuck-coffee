extends Node

# X is sides
# Y is up/down (keep on 0, if it shall stay on bottom of something)
# Z is front/back

const ray_length = 1000

onready var Striker = $Striker
onready var WorldCam = $Camera

export var speed = 0.5

var last_delta = 0
var is_captured = false
var move_to_pos = Vector3.ZERO


# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
#	pass


# credits to ZeroTheOtaku for this code snippet/solution:
func _input(event) -> void:
	if event is InputEventMouseButton && event.pressed: 
		is_captured = !is_captured 
		#print("captured set to: " + String(is_captured)) 
		if !is_captured: 
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE) 
		else: 
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED) 

	if event is InputEventMouseMotion and is_captured: 
		# striker movement code!!!!!
		move_to_pos = Vector3(event.relative.x * speed, 0, event.relative.y * speed) 
		move_to_pos = $Striker.move_and_slide(move_to_pos, Vector3(0, 1, 0)) 
		#print(move_to_pos)
