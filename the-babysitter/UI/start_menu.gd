extends Control

@onready var play_button: Button = $Play_button
@onready var instructions_button: Button = $Instructions_button



func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://World/world.tscn")


func _on_instructions_button_pressed() -> void:
	get_tree().change_scene_to_file("res://UI/instructions_menu.tscn")
