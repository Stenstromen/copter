extends CharacterBody2D

@export var speed = 700
@export var gravity = 200
@export var upforce = 180

# Reference to the score label
@onready var score_label = $CanvasLayer/UserInterface/ScoreLabel

# Game state
var is_game_over = false
var current_score = 0

# Game over scene
var game_over_scene = preload("res://scenes/game_over.tscn")

func _physics_process(delta):
	# Don't process if game is over
	if is_game_over:
		return
		
	# Apply gravity over time
	velocity.y += gravity * delta
	if velocity.y > 1000:
		velocity.y = 1000

	# Move horizontally
	velocity.x = speed + position.x/100
	
	if Input.is_action_pressed("ui_select") or Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		velocity.y = -upforce

	# Apply movement
	move_and_slide()
	
	# Check for collisions with platforms
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider() is StaticBody2D:
			# Collision detected with platform
			print("Collision detected! Calling game_over()")
			game_over()
			return
	
	# Calculate score based on position.x/100
	current_score = int(position.x / 100)
	
	# Update the score label
	score_label.text = "Score: " + str(current_score)

func game_over():
	print("Game over function called!")
	is_game_over = true
	
	# Stop the copter
	velocity = Vector2.ZERO
	
	# Create and show game over scene
	print("Creating game over scene...")
	var game_over_instance = game_over_scene.instantiate()
	print("Adding game over scene to tree...")
	# Add to the copter's CanvasLayer so it appears on top
	$CanvasLayer.add_child(game_over_instance)
	print("Setting score to: ", current_score)
	
	# Set the final score
	game_over_instance.set_score(current_score)
	print("Game over setup complete!")
