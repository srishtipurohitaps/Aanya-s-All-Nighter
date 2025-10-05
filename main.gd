extends Node2D

var current_level = 1
var score = 0
var drinks = 3
var fatigue = 0.0
var pages_goal = [30, 60, 100]
var fatigue_rates = [0.25, 0.45, 0.75]
var fatigue_rate = 0.25

func _ready():
	start_level(1)

func start_level(n):
	current_level = n
	score = 0
	fatigue = 0
	drinks = 3 if n == 1 else 2 if n == 2 else 1
	fatigue_rate = fatigue_rates[n-1]
	$Background.color = Color("#2a306c") if n == 1 else Color("#9d363c") if n == 2 else Color("#FFD700")
	$CanvasLayer/ScoreLabel.text = "Pages Typed: %d/%d" % [score, pages_goal[n-1]]
	$CanvasLayer/EnergyLabel.text = "Energy Drinks: %d" % drinks
	$CanvasLayer/FatigueBar.value = fatigue

func _input(event):
	if event.is_action_pressed("ui_accept") and drinks > 0:
		$Aanya.is_boosting = true
		drinks -= 1
		fatigue += 2
		$CanvasLayer/EnergyLabel.text = "Energy Drinks: %d" % drinks
	if event.is_action_released("ui_accept"):
		$Aanya.is_boosting = false

func _process(delta):
	# Make sure Aanya exists, for bulletproof code:
	if has_node("Aanya"):
		if $Aanya.is_boosting:
			fatigue += delta * fatigue_rate * 2
			score += int(4 * delta)
		else:
			fatigue += delta * fatigue_rate
			score += int(delta)
		$CanvasLayer/ScoreLabel.text = "Pages Typed: %d/%d" % [score, pages_goal[current_level - 1]]
		$CanvasLayer/FatigueBar.value = fatigue
		if fatigue >= 10:
			game_over()
		if score >= pages_goal[current_level - 1]:
			next_level()
		if $Aanya.position.x >= 760:
			$Aanya.position.x = 0
			if current_level >= 2:
				drinks += 1
				$CanvasLayer/EnergyLabel.text = "Energy Drinks: %d" % drinks

func next_level():
	if current_level >= 3:
		show_win_screen()
	else:
		start_level(current_level + 1)

func game_over():
	get_tree().paused = true
	var msg = Label.new()
	msg.text = "Aanya dozed off!\nPages: %d\nPress R to restart" % score
	msg.position = Vector2(250, 260)
	add_child(msg)

func show_win_screen():
	get_tree().paused = true
	var msg = Label.new()
	msg.text = "You survived all 3 levels!\nTotal Pages: %d\nPress R to restart" % score
	msg.position = Vector2(220, 260)
	add_child(msg)

func _unhandled_input(event):
	if event.is_action_pressed("restart"):
		get_tree().reload_current_scene()
