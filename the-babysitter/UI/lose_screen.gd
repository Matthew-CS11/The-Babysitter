extends Control
@onready var music: AudioStreamPlayer = $music

func _ready() -> void:
	music.play()

func _on_retry_button_pressed() -> void:
	music.stop()
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().change_scene_to_file("res://World/world.tscn")
