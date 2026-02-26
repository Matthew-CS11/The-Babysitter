extends Node3D

@export var enemy_scene : PackedScene

var spawn_points: Array[Node] = []

func _ready() -> void:
	spawn_points = get_tree().get_nodes_in_group("spawn_points")
	
	spawn_all()
	
func spawn_all():
	for spawn_point in spawn_points:
		spawn_enemy(spawn_point)

func spawn_enemy(spawn_point : Marker3D):
	var enemy_instance = enemy_scene.instantiate()
	
	get_tree().current_scene.add_child.call_deferred(enemy_instance)
	enemy_instance.global_position = spawn_point.global_position
