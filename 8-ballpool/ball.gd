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
	if GameData.player == 0 and GameData.player1ball == 0:
		if is_in_group("b"):
			GameData.player1ball = 1
		else:
			GameData.player1ball = 2
		print("player 1 ball is: ", GameData.player1ball)
	elif GameData.player == 1 and GameData.player2ball == 0:
		if is_in_group("s"):
			GameData.player2ball = 1
		else:
			GameData.player2ball = 2
		print("player 2 ball is: ", GameData.player2ball)
	if is_in_group("b") and GameData.player1ball or GameData.player2ball == 2:
		print("player put not-striped ball when they wernt suposed to")
		GameData.foul = true
	elif is_in_group("s") and GameData.player1ball or GameData.player2ball == 1:
		print("player put striped ball when they wernt suposed to")
		GameData.foul = true
