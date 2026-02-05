extends Area3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		animation_player.play("open_door")


func _on_body_exited(body: Node3D) -> void:
	animation_player.play("close_door")
