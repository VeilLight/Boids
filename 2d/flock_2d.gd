extends Node2D

# The size of the flock, i.e. the total number of boids
const FLOCK_SIZE: int = 100
# The distance from the window bounds at which boids will spawn
const BOID_SPAWN_MARGIN: int = 55
const SEPARATION_WEIGHT: float = 0.06
const ALIGNMENT_WEIGHT: float = 0.35
const COHESION_WEIGHT: float = 0.05
const STEER_WEIGHT: float = 0.005
const STEER_DISTANCE: int = 200

enum STEER_DIRECTION { TO=1, AWAY=-1, NONE=0 }

var flock = []
var flock_height_bound: int = 0
var steer_direction: STEER_DIRECTION = STEER_DIRECTION.NONE
var steer_position: Vector2 = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	var boid_scene = preload("res://2d/boid_2d.tscn")
	var size = get_window().size
	flock_height_bound = size.y - $Properties.size.y
	var max_x = size.x - BOID_SPAWN_MARGIN
	var max_y = flock_height_bound - BOID_SPAWN_MARGIN
	
	for i in range(FLOCK_SIZE):
		var boid = boid_scene.instantiate()
		var initial_x = randf_range(BOID_SPAWN_MARGIN, max_x)
		var initial_y = randf_range(BOID_SPAWN_MARGIN, max_y)
		boid.set_inital_position(Vector2(initial_x, initial_y))
		boid.set_window_bounds(max_x, max_y, BOID_SPAWN_MARGIN)
		boid.set_speed($Properties/BoidSpeed/HSlider.value)
		flock.append(boid)
		add_child(boid)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	for boid in flock:
		var separation: Vector2 = _apply_separation(boid)
		var alignment: Vector2 = _apply_alignment(boid)
		var cohesion: Vector2 = _apply_cohesion(boid)
		var steering: Vector2 = _apply_steering(boid)
		var velocity: Vector2 = separation + alignment + cohesion + steering
		
		if !velocity.is_equal_approx(Vector2.ZERO):
			boid.update_velocity(velocity)

func _input(event):
	if !event is InputEventMouseButton:
		return
		
	var mouse_event = event as InputEventMouseButton
	
	# Check if it's a click on the Properties panel
	var mouse_position: Vector2 = event.position
	if mouse_position.y >= flock_height_bound:
		return
	
	if !mouse_event.pressed:
		steer_direction = STEER_DIRECTION.NONE
		return
	
	match mouse_event.button_index:
		MOUSE_BUTTON_LEFT:
			steer_direction = STEER_DIRECTION.TO
			steer_position = mouse_position
		MOUSE_BUTTON_RIGHT:
			steer_direction = STEER_DIRECTION.AWAY
			steer_position = mouse_position

func _on_boid_speed_value_changed(speed: int):
	for boid in flock:
		boid.set_speed(speed)

func _apply_separation(boid):
	var separation = Vector2()
	
	for b in flock:
		if b == boid:
			continue
		
		var to_other = boid.position - b.position
		if to_other.length() > $Properties/VisualRange/HSlider.value:
			continue
		
		separation += to_other
	
	var separation_factor = _get_slider_percentage($Properties/Separation/HSlider)
	if separation_factor == 0:
		return Vector2()
	
	separation_factor *= SEPARATION_WEIGHT
	return separation * separation_factor

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
	var alignment_factor = _get_slider_percentage($Properties/Alignment/HSlider)
	if alignment_factor == 0:
		return Vector2()
	
	alignment_factor *= ALIGNMENT_WEIGHT
	return (avg_velocity - boid.get_velocity()) * alignment_factor

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
	var cohesion_factor = _get_slider_percentage($Properties/Cohesion/HSlider)
	if cohesion_factor == 0:
		return Vector2()
		
	cohesion_factor *= COHESION_WEIGHT
	return (center_of_mass_position - boid.position) * cohesion_factor
	
func _apply_steering(boid):
	var final_position: Vector2 = steer_position - boid.position
	var distance = final_position.length()
	
	if steer_direction == STEER_DIRECTION.TO && distance < STEER_DISTANCE:
		return Vector2()
	elif steer_direction == STEER_DIRECTION.AWAY && distance > STEER_DISTANCE:
		return Vector2()
	
	return steer_direction * final_position * STEER_WEIGHT

func _get_slider_percentage(slider: HSlider):
	return slider.value / slider.max_value
