extends CharacterBody2D

@export var bat_color:Color = "#fff"

@export var ACCELERATION = 2000
@export var MAX_SPEED = 75
@export var KNOCKBACK_SPEED = 200

@onready var animatedSprite = $AnimatedSprite
@onready var playerDetectionZone = $PlayerDetectionZone
@onready var stats = $Stats

const EnemyDeathEffect = preload("res://Effects/EnemyDeathEffect.tscn")

var knockback = Vector2.ZERO

enum {
	IDLE,
	WANDER,
	CHASE
}

var state = IDLE

func _ready():
	animatedSprite.modulate = bat_color

func _physics_process(delta):
#	velocity = knockback.move_toward(Vector2.ZERO, KNOCKBACK_SPEED * delta)
	
	match state:
		IDLE:
#			velocity = velocity.move_toward(Vector2.ZERO, MAX_SPEED * delta)
			seek_player()
		WANDER:
			pass
			
		CHASE:
			var player = playerDetectionZone.player
			if player != null:
				var direction = (player.global_position - global_position).normalized()
				velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
				
	move_and_slide()
			
func seek_player():
	if playerDetectionZone.can_see_player():
		state = CHASE
	
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
