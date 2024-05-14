extends CharacterBody2D


const SPEED = 100.0

enum PLAYER_STATE {
	IDLE,
	WALKING,
	
	ATTACK,
	DEFENSE
}

var playerState: PLAYER_STATE

var dir: String = "down"

func _physics_process(delta):
	
	var direction := Input.get_vector("left", "right", "up", "down")
	
	if Input.is_action_just_pressed("attack", true) :
		attack()
		playerState = PLAYER_STATE.ATTACK
	elif playerState != PLAYER_STATE.ATTACK :
		# determine whether the player is walking or not.
		if direction.x == 0 and direction.y == 0 :
			playerState = PLAYER_STATE.IDLE
		elif direction.x != 0 or direction.y != 0 :
			playerState = PLAYER_STATE.WALKING
		# set the velocity
		velocity = direction * SPEED
		# inherited method call to move the player
		move_and_slide()
		
	# change the animation group
	playAnimation(direction)
	

func attack() :
	if playerState == PLAYER_STATE.ATTACK :
		print("wait...")
		return
	print("attack")

func playAnimation(direction: Vector2):
	
	var state: String;
	
	if playerState != PLAYER_STATE.ATTACK :
		# Which direction the player is faced
		# y dir
		if direction.y < 0 :
			dir = "up"
		elif direction.y > 0 :
			dir = "down"
		# x dir
		if direction.x < 0 :
			dir = "side"
			$AnimatedSprite2D.flip_h = true
		elif direction.x > 0 :
			dir = "side"
			$AnimatedSprite2D.flip_h = false
	
		# check state
		if playerState == PLAYER_STATE.WALKING :
			state = "walk"
		elif state != "attack" :
			state = "idle"
	else :
		state = "attack"
	
	$AnimatedSprite2D.play(dir + "_" + state)
	#print(dir + "_" + state)

func _on_animated_sprite_2d_animation_finished():
	if playerState == PLAYER_STATE.ATTACK : 
		playerState = PLAYER_STATE.IDLE
