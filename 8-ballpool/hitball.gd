extends RigidBody2D

var can = true
var aiming = false

func _physics_process(delta: float) -> void:
	if linear_velocity < Vector2(1.0, 1.0):
		can = true
	else:
		can = false

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				if event.global_position.distance_to(global_position) <= 30:
					aiming = true
			else:
				if aiming:
					shootball(event.global_position)
					
func shootball(mp):
	var direction = global_position - mp
	apply_central_impulse(direction)
	get_tree().call_group("stick", "rel", global_position)
