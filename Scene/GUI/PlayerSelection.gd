extends Button

func _on_Button_toggled(button_pressed):
	if button_pressed:
		$main1.show()
		$main2.show()
	else:
		$main1.hide()
		$main2.hide()

func _on_main1_pressed():
	var player = get_tree().get_root().find_node("Player",true,false)
	player.character = load("res://Resource/Legend/koltar.tres")
	player.initialise()
	player.is_climbing = false
	pressed = false
	_on_Button_toggled(false)

func _on_main2_pressed():
	var player = get_tree().get_root().find_node("Player",true,false)
	player.character = load("res://Resource/Legend/redmonster.tres")
	player.initialise()
	player.is_climbing = false
	pressed = false
	_on_Button_toggled(false)
	pass # Replace with function body.
