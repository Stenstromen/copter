extends StaticBody2D

@export var copter_path: NodePath
@export var spawn_offset_x: int = 200  # distance between platforms
@export var trigger_ahead_distance: int = 700  # how far ahead the copter must be
@export var platform_height_offset: int = 10

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
		new_platform.global_position = Vector2(global_position.x + spawn_offset_x, global_position.y + platform_height_offset)
		new_platform.copter_path = copter.get_path()
		get_parent().add_child(new_platform)
