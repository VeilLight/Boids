extends Polygon2D

# The distance at which boids are able to see each other.
const NEIGHBOURHOOD_DISTANCE = 50

var screen_width = 0
var screen_height = 0
var velocity = Vector2()
var max_speed = 0
var min_speed = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	var size = get_window().size
	screen_width = size.x
	screen_height = size.y
	max_speed = get_meta("max_speed")
	min_speed = get_meta("min_speed")
	
	# Choose a random direction to start flying into
	var angle = randf_range(0, 2 * PI)
	update_velocity(Vector2(cos(angle), sin(angle)))
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	translate(velocity)
	if _out_of_screen_bounds():
		_navigate_to_other_side_of_screen()

func _out_of_screen_bounds():
	return position.x > screen_width \
		|| position.x < 0 \
		|| position.y > screen_height \
		|| position.y < 0

func _navigate_to_other_side_of_screen():
	if position.x > screen_width:
		set_position(Vector2(0, position.y))
	elif position.x < 0:
		set_position(Vector2(screen_width, position.y))
	if position.y > screen_height:
		set_position(Vector2(position.x, 0))
	elif position.y < 0:
		set_position(Vector2(position.x, screen_height))

func update_velocity(_velocity: Vector2):
	velocity += _velocity
	
	# Limit speed between a minimum and maximum
	var velocity_magnitude = velocity.length()
	var speed = max(min(velocity_magnitude, get_meta("max_speed")), get_meta("min_speed"))
	velocity = velocity / velocity_magnitude * speed
	
	# Update model rotation to match the new flight direction
	set_rotation(velocity.angle() + deg_to_rad(90))

