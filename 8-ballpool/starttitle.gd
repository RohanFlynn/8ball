extends Label

var s = false
var a = 0.5
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if s:
		if position.y >= -500:
			a += 0.025
			position.y -= a
		else:
			queue_free()
	

func start():
	s = true
