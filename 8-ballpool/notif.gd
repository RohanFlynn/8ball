extends Control

var notif = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scale.x = 0
	scale.y = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if notif:
		if scale.x <= 1:
			scale.x += 0.01
			scale.y += 0.01
		else:
			await get_tree().create_timer(2.0).timeout
			notif = false
			scale.x = 0
			scale.y = 0

func notify(p):
	notif = true
