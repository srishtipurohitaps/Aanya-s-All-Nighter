extends Node2D

var is_boosting = false

const SPEED_NORMAL = 180.0
const SPEED_BOOST  = 340.0

func _process(delta):
	var speed = SPEED_BOOST if is_boosting else SPEED_NORMAL
	position.x += speed * delta
	position.x = clamp(position.x, 0.0, 760.0)
