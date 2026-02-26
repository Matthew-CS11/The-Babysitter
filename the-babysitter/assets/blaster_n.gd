extends Node3D

@export var recoil_rotation_x : Curve
@export var recoil_rotation_z : Curve
@export var recoil_position_z : Curve
@export var recoil_amplitude := Vector3(1,1,1)
@export var lerp_speed : float = 1
@export var range: float = 100.0
@export var damage: int = 25

@onready var weapon: Node3D = $".."
@onready var muzzle: Marker3D = $"../Muzzle_Marker"

var ammo = preload("res://player/bullet.tscn")
var target_rot : Vector3
var target_pos : Vector3
var current_time : float

func _ready() -> void:
	target_rot.y = rotation.y
	current_time = 1
	
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("fire"):
		apply_recoil()
		shoot()
	
	if current_time < 1:
		current_time += delta
		position.z = lerp(position.z, target_pos.z, lerp_speed * delta)		
		rotation.z = lerp(rotation.z, target_rot.z, lerp_speed * delta)
		rotation.x = lerp(rotation.x, target_rot.x, lerp_speed * delta)
		
		target_rot.z = recoil_rotation_z.sample(current_time) * recoil_amplitude.y
		target_rot.x = recoil_rotation_x.sample(current_time) * -recoil_amplitude.x
		target_pos.z = recoil_position_z.sample(current_time) * recoil_amplitude.z
		
func apply_recoil():
	recoil_amplitude.y *= -1 if randf() > .5 else 1
	target_rot.z = recoil_rotation_z.sample(0)
	target_rot.x = recoil_rotation_x.sample(0)
	target_pos.z = recoil_position_z.sample(0)
	current_time = 0
	
	
func shoot() -> void:
	var from = muzzle.global_position
	var to = from + (-muzzle.global_transform.basis.z) * range
	var space_state = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(from, to)
	
	query.exclude = [self, get_parent()]
	
	var hit = space_state.intersect_ray(query)
	
	if hit:
		handle_hit(hit)
	var tracer = ammo.instantiate()
	get_tree().current_scene.add_child(tracer)
	tracer.global_position = from
	tracer.direction = (to - from).normalized()	
		
		
func handle_hit(hit: Dictionary) -> void:
	var c = hit.collider
	
	if c is Area3D:
		var a := c as Area3D
		if a.is_in_group("damage_area"):
			var enemy = a.owner
			if enemy and enemy.has_method("take_damage"):
				enemy.take_damage(damage)
			return
			
	if c is Node and (c as Node).has_method("take_damage"):
		(c as Node).take_damage(damage)
		return
	
