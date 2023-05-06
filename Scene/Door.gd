extends Area2D

var can_enter = false
onready var levelname = get_parent().name

func _ready():
	$Label.hide()

func _process(delta):
	if can_enter:
		$Label.show()
		if Input.is_action_just_pressed("Enter"):
			var n = int(levelname[-1])
			n += 1
			if ResourceLoader.exists("res://Scene/Levels/level"+str(n)+".tscn"):
				get_tree().change_scene("res://Scene/Levels/level"+str(n)+".tscn")
	else:
		$Label.hide()

func _on_Door_body_entered(body):
	if body == Global.Player:
		can_enter = true

func _on_Door_body_exited(body):
	if body == Global.Player:
		can_enter = false
