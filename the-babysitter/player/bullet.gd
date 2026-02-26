extends Area3D


@export var speed := 60.0
@export var damage := 25
@export var lifetime := 3.0

var direction: Vector3 = Vector3.ZERO
var last_pos : Vector3
var shooter : Node3D

func _ready() -> void:
	last_pos = global_position
	
	await get_tree().create_timer(lifetime).timeout
	queue_free()

func _physics_process(delta: float) -> void:
	if direction == Vector3.ZERO:
		return
	
	var next_pos = global_position + direction * speed *delta
	var space_state = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(last_pos, next_pos)
	
	query.exclude = [self, get_parent()]
	query.exclude = [self]
	
	if shooter:
		query.exclude.append(shooter)
	var hit = space_state.intersect_ray(query)
	
	if hit:
		print("BULLET HIT:", hit.collider, "at", hit.position, "dist", last_pos.distance_to(hit.position))
		
	if hit:
		handle_hit(hit.collider)
		return
	global_position = next_pos
	last_pos = global_position

func handle_hit(collider: Object) -> void:
	if collider is Area3D:
		var area := collider as Area3D
		if area.is_in_group("damage_area"):
			var enemy = area.owner
			if enemy and enemy.has_method("take_damage"):
				enemy.take_damage(damage)
	queue_free()
	
func _on_area_entered(area: Area3D) -> void:
	if area.is_in_group("damage_area"):
		var enemy = area.get_parent()
		print("meow")
		if enemy and enemy.has_method("take_damage"):
			enemy.take_damage(25)
		queue_free()
		return
