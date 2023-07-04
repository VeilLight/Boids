extends Node2D

# The size of the flock, a.k.a the total number of boids
const FLOCK_SIZE = 100

# Represents by how much a boid will turn away from neighbours.
# The lower the number, the higher the turn gets.
const SEPARATION_FACTOR = 200

# Represents by how much a boid will align with its neighbours directions.
# The lower the number, the higher the alignment gets.
const ALIGNMENT_FACTOR = 18

# The amount of approximation towards the neighbours center of mass.
# The lower the number, the higher the approximation gets.
const COHESION_FACTOR = 500

var boid_scene = preload("res://2d/boid_2d.tscn")
var flock = []

# Called when the node enters the scene tree for the first time.
func _ready():
	var size = get_window().size
	for i in range(FLOCK_SIZE):
		var boid = boid_scene.instantiate()
		var initial_x = randf_range(0, size.x)
		var initial_y = randf_range(0, size.y)
		boid.set_position(Vector2(initial_x, initial_y))
		flock.append(boid)
		add_child(boid)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	for boid in flock:
		var separation = _apply_separation(boid)
		var alignment = _apply_alignment(boid)
		var cohesion = _apply_cohesion(boid)
		var velocity = separation + alignment + cohesion
		boid.update_velocity(velocity)

func _apply_separation(boid):
	var separation = Vector2()
	
	for b in flock:
		if b == boid:
			continue
		
		var to_other = boid.position - b.position
		if to_other.length() > boid.NEIGHBOURHOOD_DISTANCE:
			continue
		
		separation += to_other
	
	return separation / SEPARATION_FACTOR

func _apply_alignment(boid):
	var avg_neighbours_velocities = Vector2()
	var neighbours = 0
	
	for b in flock:
		if b == boid:
			continue
		
		var distance = boid.position.distance_to(b.position)
		if distance > boid.NEIGHBOURHOOD_DISTANCE:
			continue
		
		avg_neighbours_velocities += b.get_velocity()
		neighbours += 1
	
	if neighbours == 0:
		return Vector2()
	
	var avg_velocity = avg_neighbours_velocities / neighbours
	return (avg_velocity - boid.get_velocity()) / ALIGNMENT_FACTOR

func _apply_cohesion(boid):
	var avg_neighbours_positions = Vector2()
	var neighbours = 0
	
	for b in flock:
		if b == boid:
			continue
		
		var distance = boid.position.distance_to(b.position)
		if distance > boid.NEIGHBOURHOOD_DISTANCE:
			continue
		
		avg_neighbours_positions += b.position
		neighbours += 1
	
	if neighbours == 0:
		return Vector2()
	
	var center_of_mass_position = avg_neighbours_positions / neighbours
	return (center_of_mass_position - boid.position) / COHESION_FACTOR
