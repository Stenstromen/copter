extends CharacterBody2D

@export var speed = 150
@export var gravity = 100
@export var upforce = 15

func _physics_process(delta):
	# Apply gravity over time
	velocity.y += gravity * delta
	if velocity.y > 1000:
		velocity.y = 1000

	# Move horizontally
	velocity.x = speed

	# Apply movement
	move_and_slide()

	print(velocity)
