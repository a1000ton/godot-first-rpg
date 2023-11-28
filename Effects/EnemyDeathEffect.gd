extends Node2D

@onready var animatedSprite = $AnimatedSprite2D

func _ready():
	animatedSprite.play("Die")


func _on_animated_sprite_2d_animation_finished():
	queue_free()
