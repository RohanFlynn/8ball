extends Area2D

func _physics_process(delta: float) -> void:
	var bods = get_overlapping_bodies()
	for b in bods:
		if b.get_parent() == %balls:
			b.queue_free()
