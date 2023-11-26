extends CharacterBody2D

const ACCELERATION = 1000
const MAX_SPEED = 75
const ROLL_SPEED = 95

@onready var animationPlayer = $AnimationPlayer
@onready var animationTree = $AnimationTree
@onready var animationState = animationTree.get("parameters/playback")

enum {
	MOVE,
	ROLL,
	ATTACK,
	SPECIAL_ATTACK
}

var state = MOVE
var roll_vector = Vector2.LEFT

func _ready():
	animationTree.active = true

func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)
		ROLL:
			roll_state(delta)
		ATTACK:
			attack_state(delta)
		SPECIAL_ATTACK:
			special_attack_state(delta)
	
func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		roll_vector = input_vector
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationTree.set("parameters/Attack/blend_position", input_vector)
		animationTree.set("parameters/Roll/blend_position", input_vector)

		animationState.travel("Run")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		animationState.travel("Idle")
		velocity.x = move_toward(velocity.x, 0, MAX_SPEED)
		velocity.y = move_toward(velocity.y, 0, MAX_SPEED)
		
	move_and_slide()
	
	if Input.is_action_just_pressed("attack"):
		state = ATTACK
		
	if Input.is_action_just_pressed("attack_special"):
		state = SPECIAL_ATTACK
		
	if Input.is_action_just_pressed("roll"):
		state = ROLL
	
func attack_state(delta):
	animationState.travel("Attack")
	
func attack_animation_finished():
	state = MOVE
	
func roll_state(delta):
	velocity = roll_vector * ROLL_SPEED
	animationState.travel("Roll")
	move_and_slide()
	
func roll_animation_finished():
	state = MOVE

func special_attack_state(delta):
	animationState.travel("SpecialAttack")
	
