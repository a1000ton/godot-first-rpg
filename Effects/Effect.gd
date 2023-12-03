extends AnimatedSprite2D

func _ready():
	play("Animate")

func _on_animation_finished():
	queue_free()
