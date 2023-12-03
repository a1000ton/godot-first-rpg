extends Node

@export var max_health = 1
@onready var health = max_health :
	set(val):
		health = val
		if (health <= 0):
			emit_signal("no_health")

signal no_health
