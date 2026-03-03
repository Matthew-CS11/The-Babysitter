extends Control

@onready var play_button: Button = $Play_button
@onready var instructions_button: Button = $Instructions_button
@onready var menu_music: AudioStreamPlayer = $Menu_music


func _ready() -> void:
	menu_music.play()

func _on_play_button_pressed() -> void:
	menu_music.stop()
	get_tree().change_scene_to_file("res://World/world.tscn")


func _on_instructions_button_pressed() -> void:
	get_tree().change_scene_to_file("res://UI/instructions_menu.tscn")
