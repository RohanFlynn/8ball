extends RigidBody2D

var can = true
var aiming = false
var shot = false
var bshot = false
var lp = Vector2()
var mp = Vector2()
@onready var line: Line2D = $powerline
@onready var line2: Line2D = $Line2D

func _physics_process(delta: float) -> void:
	if linear_velocity.length() < 1.0:
		can = true
	else:
		can = false
	if aiming:
		line.points[1] = get_local_mouse_position()
		line2.points[1] = (get_local_mouse_position() * -1)
	elif bshot:
		line2.points[1] = Vector2(0, 0)
		if line.points[1].length() > 1:
			line.points[1] -= lp / 10
		else:
			line.points[1] = Vector2.ZERO
			shot = true
			if shot:
				shootball(mp)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed and can:
				if event.global_position.distance_to(global_position) <= 30:
					aiming = true
			else:
				if aiming:
					aiming = false
					bshot = true
					lp = line.points[1]
					mp = event.global_position
					
func shootball(mp):
	shot = false
	bshot = false
	var direction = global_position - mp
	apply_central_impulse(direction)
	get_tree().call_group("stick", "rel", global_position)
