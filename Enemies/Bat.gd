extends CharacterBody2D

@export var bat_color:Color = "#fff"
@export var knockback = Vector2.ZERO

@onready var animatedSprite = $AnimatedSprite
@onready var stats = $Stats

const EnemyDeathEffect = preload("res://Effects/EnemyDeathEffect.tscn")

func _ready():
	animatedSprite.modulate = bat_color

func _physics_process(delta):
	velocity = knockback.move_toward(Vector2.ZERO, 200 * delta)
	knockback = velocity
	move_and_slide()
	
func create_death_effect():
	var enemyDeathEffect = EnemyDeathEffect.instantiate()
	get_parent().add_child(enemyDeathEffect)
	enemyDeathEffect.global_position = global_position

func _on_hurtbox_area_entered(area):
	stats.health -= area.damage
	knockback = area.knockback_vector * 120
	
func die():
	queue_free()

func _on_stats_no_health():
	queue_free()
	create_death_effect()
