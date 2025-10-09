extends Node2D

var current_level = 1
var score = 0.0
var drinks = 3
var fatigue = 0.0
var game_active = true  

var pages_goal = [150, 320, 520]
var fatigue_rates = [0.08, 0.11, 0.15]
var fatigue_rate = 0.08

var boost_indicator: Label

func _ready():
	boost_indicator = Label.new()
	boost_indicator.text = "⚡ BOOSTING! ⚡"
	boost_indicator.position = Vector2(280, 120)
	boost_indicator.add_theme_color_override("font_color", Color.YELLOW)
	boost_indicator.add_theme_font_size_override("font_size", 28)
	boost_indicator.visible = false
	$CanvasLayer.add_child(boost_indicator)

	var help_node = $CanvasLayer.get_node_or_null("HelpLabel")
	if help_node:
		help_node.text = "SPACE = Boost (uses drink)\nReach pages to advance\nFatigue kills you\nF = Restart"
		fade_out_help_later()

	start_level(1)

func fade_out_help_later():
	var t = Timer.new()
	t.wait_time = 8.0
	t.one_shot = true
	add_child(t)
	t.timeout.connect(func():
		var help_node = $CanvasLayer.get_node_or_null("HelpLabel")
		if help_node:
			help_node.visible = false
	)
	t.start()

func start_level(n):
	current_level = n
	score = 0.0
	fatigue = 0.0
	drinks = 3 if n == 1 else 2 if n == 2 else 1
	fatigue_rate = fatigue_rates[n - 1]
	game_active = true

	var colors = [Color("#1e3a8a"), Color("#7f1d1d"), Color("#d97706")]
	$Background.color = colors[n - 1]
	
	$CanvasLayer.get_node("ScoreLabel").text = "Pages: 0/%d" % pages_goal[n - 1]
	$CanvasLayer.get_node("EnergyLabel").text = "Drinks: %d" % drinks
	$CanvasLayer.get_node("FatigueBar").value = 0.0

	if has_node("Aanya"):
		$Aanya.is_boosting = false
		$Aanya.position.x = 50.0
	boost_indicator.visible = false

func _unhandled_input(event):
	# Restart always works
	if event.is_action_pressed("ui_restart"):
		get_tree().reload_current_scene()
		return

	if not game_active:
		return

	# Boost handling
	if event.is_action_pressed("ui_accept") and drinks > 0 and has_node("Aanya"):
		$Aanya.is_boosting = true
		boost_indicator.visible = true
		drinks -= 1
		fatigue += 1.0
		$CanvasLayer.get_node("EnergyLabel").text = "Drinks: %d" % drinks
	if event.is_action_released("ui_accept") and has_node("Aanya"):
		$Aanya.is_boosting = false
		boost_indicator.visible = false

func _process(delta):
	# Always allow restart check
	if Input.is_action_just_pressed("ui_restart"):
		get_tree().reload_current_scene()
		return

	if not game_active:
		return

	var normal_speed = 2.5
	var boost_speed = 8.0

	if has_node("Aanya") and $Aanya.is_boosting:
		score += boost_speed * delta
		fatigue += delta * fatigue_rate * 2.8
		boost_indicator.modulate = Color.YELLOW if int(Time.get_time_dict_from_system()["second"] * 4) % 2 == 0 else Color.RED
	else:
		score += normal_speed * delta
		fatigue += delta * fatigue_rate

	$CanvasLayer.get_node("ScoreLabel").text = "Pages: %d/%d" % [int(score), pages_goal[current_level - 1]]
	$CanvasLayer.get_node("FatigueBar").value = fatigue

	if fatigue >= 10.0:
		game_over()
		return
	if score >= pages_goal[current_level - 1]:
		next_level()
		return
	if has_node("Aanya") and $Aanya.position.x >= 760.0:
		$Aanya.position.x = 0.0
		if current_level >= 2 and drinks < 3:
			drinks += 1
			$CanvasLayer.get_node("EnergyLabel").text = "Drinks: %d" % drinks

func next_level():
	if current_level >= 3:
		show_win_screen()
	else:
		start_level(current_level + 1)

func game_over():
	game_active = false
	boost_indicator.visible = false
	var msg = Label.new()
	msg.text = "💤 Aanya fell asleep!\nPages: %d\nPress F to restart" % int(score)
	msg.position = Vector2(150, 200)
	msg.add_theme_color_override("font_color", Color.WHITE)
	msg.add_theme_font_size_override("font_size", 20)
	add_child(msg)

func show_win_screen():
	game_active = false
	boost_indicator.visible = false
	var msg = Label.new()
	msg.text = "🎉 VICTORY! 🎉\nTotal Pages: %d\nPress F to play again" % int(score)
	msg.position = Vector2(140, 200)
	msg.add_theme_color_override("font_color", Color.YELLOW)
	msg.add_theme_font_size_override("font_size", 20)
	add_child(msg)
