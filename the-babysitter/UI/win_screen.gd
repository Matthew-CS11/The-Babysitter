extends Control


func set_tracker_label(amt: int) -> void:
	$Tracker.text = "You Killed "+str(amt)+" Demons!"

func _on_play_again_pressed() -> void:
	get_tree().change_scene_to_file("res://UI/start_menu.tscn")
