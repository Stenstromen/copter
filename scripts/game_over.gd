extends Control

@onready var score_label = $VBoxContainer/ScoreLabel
@onready var restart_button = $VBoxContainer/RestartButton

func _ready():
	print("Game over scene _ready() called")
	# Make the game over scene visible
	show()
	print("Game over scene shown")

func set_score(score: int):
	print("Setting score to: ", score)
	score_label.text = "Score: " + str(score)
	print("Score label updated")

func _on_restart_button_pressed():
	# Reload the main game scene
	get_tree().change_scene_to_file("res://scenes/world.tscn")
