extends Line2D



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position = get_global_mouse_position()
	var b = get_parent().get_child(2)
	rotation = global_position.angle_to_point(b.global_position) + PI / 2

func rel(pos):
	var start_pos = global_position
	global_position = pos
