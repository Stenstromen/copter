extends CharacterBody2D

@export var speed = 700
@export var gravity = 200
@export var upforce = 180

func _physics_process(delta):
	# Apply gravity over time
	velocity.y += gravity * delta
	if velocity.y > 1000:
		velocity.y = 1000

	# Move horizontally
	velocity.x = speed
	
	if Input.is_action_pressed("ui_select"):
		velocity.y = -upforce

	# Apply movement
	move_and_slide()

	#print(velocity)
