extends CharacterBody2D

@onready var animatedSprite = $AnimatedSprite
@onready var stats = $Stats

const HIT_COLOR = "#f6004a"

var knockback = Vector2.ZERO

func _physics_process(delta):
	velocity = knockback.move_toward(Vector2.ZERO, 200 * delta)
	knockback = velocity
	move_and_slide()
	
func create_death_effect():
	var EnemyDeathEffect = load("res://Effects/EnemyDeathEffect.tscn")
	var enemyDeathEffect = EnemyDeathEffect.instantiate()
	var world = get_tree().current_scene
	world.add_child(enemyDeathEffect)
	enemyDeathEffect.global_position = global_position

func _on_hurtbox_area_entered(area):
	animatedSprite.modulate = HIT_COLOR
	stats.health -= 1
	knockback = area.knockback_vector * 120
	
func die():
	queue_free()

func _on_stats_no_health():
	animatedSprite.visible = false
	create_death_effect()
	queue_free()
