extends Polygon2D

# The distance at which boids are able to see each other.
const NEIGHBOURHOOD_DISTANCE = 25

var screen_width = 0
var screen_height = 0
var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	var size = get_window().size
	screen_width = size.x
	screen_height = size.y
	
	# Choose a random direction to start flying into
	var angle = randf_range(0, 2 * PI)
	update_velocity(Vector2(cos(angle), sin(angle)))
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	translate(velocity)
	var screen_margin = get_meta("screen_margin")
	if screen_margin > 0:
		_stay_within_scree_bounds(screen_margin)
	else:
		_navigate_to_other_side_of_screen_if_out_of_bounds()

func update_velocity(_velocity: Vector2):
	velocity += _velocity
	# Limit speed between a minimum and maximum
	_limit_velocity()
	# Update model rotation to match the new flight direction
	set_rotation(velocity.angle() + deg_to_rad(90))

func get_velocity():
	return velocity

func _stay_within_scree_bounds(screen_margin: float):
	var turn_factor = get_meta("turn_factor")
	
	if position.x < screen_margin:
		velocity.x += turn_factor
	elif position.x > screen_width - screen_margin:
		velocity.x -= turn_factor
	
	if position.y < screen_margin:
		velocity.y += turn_factor
	elif position.y > screen_height - screen_margin:
		velocity.y -= turn_factor

func _navigate_to_other_side_of_screen_if_out_of_bounds():
	if position.x > screen_width:
		set_position(Vector2(0, position.y))
	elif position.x < 0:
		set_position(Vector2(screen_width, position.y))
	if position.y > screen_height:
		set_position(Vector2(position.x, 0))
	elif position.y < 0:
		set_position(Vector2(position.x, screen_height))

func _limit_velocity():
	var velocity_magnitude = velocity.length()
	var speed = max(min(velocity_magnitude, get_meta("max_speed")), get_meta("min_speed"))
	velocity = velocity / velocity_magnitude * speed
