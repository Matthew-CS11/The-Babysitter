extends Node3D

@export var enemy_scene : PackedScene

@onready var ui: CanvasLayer = $"../UI"
@onready var spawn_timer: Timer = $spawn_timer

var last_second := 1
var demons := 0
var spawn_points: Array[Node] = []
var wave_num : int

func _ready() -> void:
	last_second = -1
	
func _process(delta: float) -> void:
	var seconds_left := int(ceil(spawn_timer.time_left))
	
	if seconds_left != last_second:
		last_second = seconds_left
		ui.set_wave_label(seconds_left)
	
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


func _on_spawn_timer_timeout() -> void:
	spawn_points = get_tree().get_nodes_in_group("spawn_points")
	wave_num += 1
	spawn_all()
	ui.set_wave_number(wave_num)
	last_second = -1
