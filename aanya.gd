extends Node2D

var is_boosting = false

func _process(delta):
	position.x += (350 if is_boosting else 200) * delta
	position.x = clamp(position.x, 0, 760)
