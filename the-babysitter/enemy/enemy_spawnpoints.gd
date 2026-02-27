extends Node3D

@export var enemy_scene : PackedScene

@onready var ui: CanvasLayer = $"../UI"

var demons := 0
var spawn_points: Array[Node] = []

func _ready() -> void:
	spawn_points = get_tree().get_nodes_in_group("spawn_points")
	spawn_all()
	
func spawn_all():
	for spawn_point in spawn_points:
		demons += 1
		update_demon_label()
		spawn_enemy(spawn_point)
		print("meow")
		
		
func spawn_enemy(spawn_point : Marker3D):
	var enemy_instance = enemy_scene.instantiate()
	
	get_tree().current_scene.add_child.call_deferred(enemy_instance)
	enemy_instance.set_deferred("global_transform", spawn_point.global_transform)
	enemy_instance.call_deferred("connect", "killed", Callable(self, "_on_enemy_killed"))
	
func update_demon_label() ->void:
	if ui.has_method("set_demon_label"):
		ui.set_demon_label(demons)

func _on_enemy_killed() -> void:
	demons -= 1
	ui.set_demon_label(demons)
