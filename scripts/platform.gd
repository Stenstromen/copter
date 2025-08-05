extends StaticBody2D

@export var copter_path: NodePath
@export var spawn_offset_x: int = 200  # distance between platforms
@export var trigger_ahead_distance: int = 700  # how far ahead the copter must be
@export var platform_height_offset: int = 0
@export var height_variation: int = 50  # max height variation for tunnel effect
@export var wave_frequency: float = 0.005  # controls how quickly the wave oscillates (lower = smoother)
@export var wave_phase: float = 0.0  # starting phase of the wave

var has_copter_passed = false
var copter: CharacterBody2D
var platform_scene: PackedScene

func _ready():
	copter = get_node(copter_path)
	platform_scene = load(scene_file_path)

func _process(delta):
	if not has_copter_passed and copter.global_position.x + trigger_ahead_distance >= global_position.x:
		has_copter_passed = true
		spawn_next_platform()

func spawn_next_platform():
	if platform_scene:
		var new_platform = platform_scene.instantiate()
		
		# Calculate the new x position
		var new_x_position = global_position.x + spawn_offset_x
		
		# Use the absolute x position for wave calculation to ensure continuity
		var wave_position = new_x_position * wave_frequency + wave_phase
		var wave_offset = sin(wave_position) * height_variation
		
		# Apply the wave offset to the platform's position
		new_platform.global_position = Vector2(
			new_x_position, 
			global_position.y + platform_height_offset + wave_offset
		)
		
		new_platform.copter_path = copter.get_path()
		get_parent().add_child(new_platform)
		
