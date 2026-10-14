extends RigidBody2D

var cancan = false
var can = true
var aiming = false
var shot = false
var bshot = false
var lp = Vector2()
var mp = Vector2()
var player = GameData.player
var shown = false
@onready var line: Line2D = $powerline
@onready var line2: Line2D = $Line2D
var able = true
var v = 0.0
var l = 0.0
@onready var before_shot

func _ready() -> void:
	before_shot = global_position
	
func _physics_process(delta: float) -> void:
	if cancan:
		if not able:
			var b = get_tree().get_nodes_in_group("Ball")
			var m = get_moving_balls(b)
			# This ball AND every other ball has stopped
			if linear_velocity.length() < 3.0 and m.is_empty():
				able = true
				if player == 0:
					GameData.player1moves -= 1
					if GameData.player1moves <= 0:
						GameData.player = 1
						player = GameData.player
						GameData.player2moves = 1
				elif player == 1:
					GameData.player2moves -= 1
					if GameData.player2moves <= 0:
						GameData.player = 0
						player = GameData.player
						GameData.player1moves = 1
				get_tree().call_group("notification", "notify", player)
				shown = true
				can = true
		if aiming:
			line.points[1] = get_local_mouse_position()
			line2.points[1] = get_local_mouse_position() * -1
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
	if cancan and able:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT:
				if event.pressed and can:
					if event.global_position.distance_to(global_position) <= 30:
						aiming = true
				else:
					if aiming:
						before_shot = global_position
						aiming = false
						bshot = true
						lp = line.points[1]
						mp = event.global_position
					
func shootball(mp):
	shot = false
	bshot = false
	able = false
	var direction = (global_position - mp) / 1.5
	apply_central_impulse(direction)
	get_tree().call_group("stick", "rel", global_position)
	shown = false

func start():
	cancan = true

func get_moving_balls(balls):
	var moving = []
	for ball in balls:
		if ball.hit == true:
			moving.append(ball)
	return moving

func leave():
	global_position = before_shot
	linear_velocity = Vector2(0, 0)
