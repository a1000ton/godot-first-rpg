extends Node2D

const GrassEffect = preload("res://Effects/GrassEffect.tscn")

func create_grass_effect():
	var grassEffect = GrassEffect.instantiate()
	get_parent().add_child(grassEffect)
	grassEffect.global_position = global_position

func _on_hurtbox_area_entered(area):
	queue_free()
	create_grass_effect()
