extends AnimatedSprite

func _ready():
	$Tween.interpolate_property(self,"modulate:a",0.6,0.0,0.5,1)
	$Tween.interpolate_property(self,"modulate:r",1.0,0.0,0.5,1)
	$Tween.interpolate_property(self,"modulate:g",1.0,0.0,0.5,1)
	$Tween.interpolate_property(self,"modulate:b",1.0,0.0,0.5,1)
	$Tween.start()

func _on_Tween_tween_completed(_object, _key):
	queue_free()

