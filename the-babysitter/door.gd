extends Area3D



func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player") and Input.is_action_just_pressed("interact"):
		pass
