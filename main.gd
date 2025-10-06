extends Node2D

var current_level = 1
var score = 0.0
var drinks = 99     
var fatigue = 0.0

var pages_goal = [300, 600, 900]
var fatigue_rates = [0.05, 0.06, 0.07]
var fatigue_rate = 0.05

func _ready():
	if $CanvasLayer.has_node("HelpLabel"):
		$CanvasLayer/HelpLabel.text = "Hold SPACE to BOOST (unlimited test drinks)\nReach page goal • Watch fatigue • R to restart"
		fade_out_help_later()
	start_level(1)

func fade_out_help_later():
	var t := Timer.new()
	t.wait_time = 5.0
	t.one_shot = true
	add_child(t)
	t.timeout.connect(func():
		if $CanvasLayer.has_node("HelpLabel"):
			$CanvasLayer/HelpLabel.visible = false
	)
	t.start()

func start_level(n):
	current_level = n
	score = 0.0
	fatigue = 0.0
	fatigue_rate = fatigue_rates[n-1]
	$Background.color = (Color("#2a306c") if n == 1 else Color("#9d363c") if n == 2 else Color("#FFD700"))
	$CanvasLayer/ScoreLabel.text = "Pages Typed: %d/%d" % [int(score), pages_goal[n-1]]
	$CanvasLayer/EnergyLabel.text = "Energy Drinks: ∞ (test)"
	$CanvasLayer/FatigueBar.value = fatigue
	get_tree().paused = false
	if has_node("Aanya"):
		$Aanya.is_boosting = false
		$Aanya.position.x = 50.0

func _input(event):
	if event.is_action_pressed("ui_accept"):
		print("[INPUT] SPACE PRESSED")
		if has_node("Aanya"):
			$Aanya.is_boosting = true
	if event.is_action_released("ui_accept"):
		print("[INPUT] SPACE RELEASED")
		if has_node("Aanya"):
			$Aanya.is_boosting = false

func _process(delta):
	# Boost visibly affects pages per second
	var base_pps  := 3.0   # 3 pages/sec
	var boost_pps := 10.0  # 10 pages/sec when boosting

	var pps := base_pps
	if has_node("Aanya") and $Aanya.is_boosting:
		pps = boost_pps
		fatigue += delta * fatigue_rate * 1.7
	else:
		fatigue += delta * fatigue_rate

	score += pps * delta
	$CanvasLayer/ScoreLabel.text = "Pages Typed: %d/%d" % [int(score), pages_goal[current_level-1]]
	$CanvasLayer/FatigueBar.value = fatigue

	if Time.get_ticks_msec() % 500 < 16 and has_node("Aanya"):
		print("[STATE] boosting=", $Aanya.is_boosting)

	if fatigue >= 10.0:
		game_over(); return
	if score >= pages_goal[current_level-1]:
		next_level(); return

	if has_node("Aanya") and $Aanya.position.x >= 760.0:
		$Aanya.position.x = 0.0

func next_level():
	if current_level >= 3:
		show_win_screen()
	else:
		start_level(current_level + 1)

func game_over():
	if get_tree().paused: return
	get_tree().paused = true
	var msg := Label.new()
	msg.text = "Aanya dozed off!\nPages: %d\nPress R to restart" % int(score)
	msg.position = Vector2(180, 240)
	add_child(msg)

func show_win_screen():
	if get_tree().paused: return
	get_tree().paused = true
	var msg := Label.new()
	msg.text = "You survived all 3 levels!\nTotal Pages: %d\nPress R to restart" % int(score)
	msg.position = Vector2(170, 240)
	add_child(msg)

func _unhandled_input(event):
	if event.is_action_pressed("restart"):
		get_tree().paused = false
		get_tree().reload_current_scene()
