extends CharacterBody3D

@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D
@onready var player: Player = $"../player"
var agro :float = false

func _process(delta: float) -> void:
	if agro:
		navigation_agent_3d.set_target_position(player.global_position)
		
func _physics_process(delta: float) -> void:
	var destination = navigation_agent_3d.get_next_path_position()
	var local_dest = destination - global_position
	var direction = local_dest.normalized()
	
	velocity = direction * 5.0
	move_and_slide()

func _on_agression_radius_body_entered(body: Node3D) -> void:
	if "player" in body.get_groups():
		print("meow")
		agro = true
	
