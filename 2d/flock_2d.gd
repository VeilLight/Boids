extends Node2D

# The size of the flock, i.e. the total number of boids
const FLOCK_SIZE = 100
# The distance from the window bounds at which boids will spawn
const BOID_SPAWN_MARGIN = 50

var flock = []

# Called when the node enters the scene tree for the first time.
func _ready():
	var boid_scene = preload("res://2d/boid_2d.tscn")
	var size = get_window().size
	var max_x = size.x - BOID_SPAWN_MARGIN
	var max_y = size.y - $Properties.size.y - BOID_SPAWN_MARGIN
	
	for i in range(FLOCK_SIZE):
		var boid = boid_scene.instantiate()
		var initial_x = randf_range(BOID_SPAWN_MARGIN, max_x)
		var initial_y = randf_range(BOID_SPAWN_MARGIN, max_y)
		boid.setup(Vector2(initial_x, initial_y), max_y)
		flock.append(boid)
		add_child(boid)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	for boid in flock:
		var separation = _apply_separation(boid)
		var alignment = _apply_alignment(boid)
		var cohesion = _apply_cohesion(boid)
		var velocity: Vector2 = separation + alignment + cohesion
		
		if !velocity.is_equal_approx(Vector2.ZERO):
			boid.update_velocity(velocity)

func _apply_separation(boid):
	var separation = Vector2()
	
	for b in flock:
		if b == boid:
			continue
		
		var to_other = boid.position - b.position
		if to_other.length() > $Properties/VisualRange/HSlider.value:
			continue
		
		separation += to_other
	
	return separation / $Properties/Separation/HSlider.value

func _apply_alignment(boid):
	var avg_neighbours_velocities = Vector2()
	var neighbours = 0
	
	for b in flock:
		if b == boid:
			continue
		
		var distance = boid.position.distance_to(b.position)
		if distance > $Properties/VisualRange/HSlider.value:
			continue
		
		avg_neighbours_velocities += b.get_velocity()
		neighbours += 1
	
	if neighbours == 0:
		return Vector2()
	
	var avg_velocity = avg_neighbours_velocities / neighbours
	return (avg_velocity - boid.get_velocity()) / $Properties/Alignment/HSlider.value

func _apply_cohesion(boid):
	var avg_neighbours_positions = Vector2()
	var neighbours = 0
	
	for b in flock:
		if b == boid:
			continue
		
		var distance = boid.position.distance_to(b.position)
		if distance > $Properties/VisualRange/HSlider.value:
			continue
		
		avg_neighbours_positions += b.position
		neighbours += 1
	
	if neighbours == 0:
		return Vector2()
	
	var center_of_mass_position = avg_neighbours_positions / neighbours
	return (center_of_mass_position - boid.position) / $Properties/Cohesion/HSlider.value
