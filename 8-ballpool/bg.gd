extends Sprite2D

@onready var pos
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pos = global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position += Vector2(-1, 0)
