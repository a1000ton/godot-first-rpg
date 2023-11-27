extends CharacterBody2D


@onready var animatedSprite = $AnimatedSprite

var knockback = Vector2.ZERO
var dying = false

func _physics_process(delta):
	velocity = knockback.move_toward(Vector2.ZERO, 200 * delta)
	knockback = velocity
	
	if(dying && knockback == Vector2.ZERO):
		animatedSprite.visible = false
		create_death_effect()
		
	move_and_slide()
	
	
func create_death_effect():
	var EnemyDeathEffect = load("res://Effects/EnemyDeathEffect.tscn")
	var enemyDeathEffect = EnemyDeathEffect.instantiate()
	var world = get_tree().current_scene
	world.add_child(enemyDeathEffect)
	enemyDeathEffect.global_position = global_position

func _on_hurtbox_area_entered(area):
	knockback = area.knockback_vector * 120
	dying = true
	
func die():
	queue_free()
