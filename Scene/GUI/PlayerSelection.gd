extends Button

func _on_Button_toggled(button_pressed):
	if button_pressed:
		$main1.show()
		$main2.show()
	else:
		$main1.hide()
		$main2.hide()

func _on_main1_pressed():
	get_tree().change_scene("res://Scene/Menu.tscn")

func _on_main2_pressed():
	get_tree().quit()
