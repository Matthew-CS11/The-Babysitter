extends CharacterBody3D

@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		var random_pos := Vector3.ZERO
		random_pos.x = randf_range(-5.0, 5)
		random_pos.z = randf_range(-5.0, 5)
		navigation_agent_3d.set_target_position(random_pos)
		
func _physics_process(delta: float) -> void:
	var destination = navigation_agent_3d.get_next_path_position()
	var local_dest = destination - global_position
	var direction = local_dest.normalized()
	
	velocity = direction * 5.0
	move_and_slide()
