extends RigidBody2D

var leaving = false
@onready var col = $CollisionShape2D
@onready var sprite = $Sprite2D
var a = Vector2(0.01, 0.01)
var hit = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	col.scale = Vector2(0.6, 0.6)
	sprite.scale = Vector2(0.6, 0.6)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if leaving:
		col.disabled = true
		linear_velocity = linear_velocity / 1.4
		a += Vector2(0.01, 0.01)
		if scale >= Vector2(0, 0):
			scale -= a
		else:
			remove_from_group("Ball")
			queue_free()
	if linear_velocity.length() > 3.0:
		hit = true
	else:
		hit = false

func leave():
	leaving = true
