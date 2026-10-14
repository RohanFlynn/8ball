extends Label

var notif = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scale.y = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if notif:
		if scale.y <= 1:
			scale.y += 0.01
		else:
			await get_tree().create_timer(2.0).timeout
			notif = false
			scale.y = 0

func notify(p):
	text = "Player " + str(p + 1) + " Turn"
	notif = true
