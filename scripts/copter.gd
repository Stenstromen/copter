extends CharacterBody2D

@export var speed = 700
@export var gravity = 200
@export var upforce = 180

# Reference to the score label
@onready var score_label = $CanvasLayer/UserInterface/ScoreLabel

func _physics_process(delta):
	# Apply gravity over time
	velocity.y += gravity * delta
	if velocity.y > 1000:
		velocity.y = 1000

	# Move horizontally
	velocity.x = speed + position.x/100
	
	if Input.is_action_pressed("ui_select"):
		velocity.y = -upforce

	# Apply movement
	move_and_slide()
	
	# Calculate score based on position.x/100
	var score = int(position.x / 100)
	
	# Update the score label
	score_label.text = "Score: " + str(score)
	
