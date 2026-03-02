extends CharacterBody3D
class_name Enemy

@export var max_health := 50

@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D
@onready var player: Player = $"../player"

var agro :float = false
var health : int

signal killed

func _ready() -> void:
	health = max_health
	
func take_damage(amt: int) -> void:
	health -= amt
	if health <= 0:
		killed.emit()
		queue_free()

func _process(delta: float) -> void:
	navigation_agent_3d.set_target_position(player.global_position)

func _physics_process(delta: float) -> void:
	var destination = navigation_agent_3d.get_next_path_position()
	var direction = (destination - global_position).normalized()
	
	velocity = direction * 5.0
	move_and_slide()

#func _on_agression_radius_body_entered(body: Node3D) -> void:
	#if "player" in body.get_groups():
		#agro = true
	
