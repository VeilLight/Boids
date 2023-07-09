extends Polygon2D

const IN_BOUNDS_TURN_FACTOR: float = 0.8

var window_width: int = 0
var window_height: int = 0
var window_margin: int = 0
var speed: int = 0
var velocity: Vector2 = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	# Choose a random direction to start flying into
	var angle = randf_range(0, 2 * PI)
	update_velocity(Vector2(cos(angle), sin(angle)))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float):
	velocity *= speed * _delta
	_limit_speed()
	_update_rotation()
	_update_bounds()
	translate(velocity)

func set_inital_position(_initial_position: Vector2):
	set_position(_initial_position)

func set_speed(_speed: int):
	speed = _speed

func set_window_bounds(_window_width:int, _window_height: int, _window_margin: int):
	window_height = _window_height
	window_width = _window_width
	window_margin = _window_margin

func update_velocity(_velocity: Vector2):
	velocity += _velocity

func get_velocity():
	return velocity

func _update_rotation():
	# Update model rotation to match the flight direction
	set_rotation(velocity.angle() + deg_to_rad(90))

func _limit_speed():
	# Limit speed between a minimum and maximum
	var velocity_magnitude = velocity.length()
	var clamped_speed = max(min(velocity_magnitude, speed), max(speed - 1, 1))
	velocity = velocity / velocity_magnitude * clamped_speed
	
func _update_bounds():
	if window_margin > 0:
		_stay_within_screen_bounds()
	else:
		_navigate_to_other_side_of_screen_if_out_of_bounds()

func _stay_within_screen_bounds():
	if position.x < window_margin:
		velocity.x += IN_BOUNDS_TURN_FACTOR
	elif position.x > window_width - window_margin:
		velocity.x -= IN_BOUNDS_TURN_FACTOR
	
	if position.y < window_margin:
		velocity.y += IN_BOUNDS_TURN_FACTOR
	elif position.y > window_height - window_margin:
		velocity.y -= IN_BOUNDS_TURN_FACTOR

func _navigate_to_other_side_of_screen_if_out_of_bounds():
	if position.x > window_width:
		set_position(Vector2(0, position.y))
	elif position.x < 0:
		set_position(Vector2(window_width, position.y))
	if position.y > window_height:
		set_position(Vector2(position.x, 0))
	elif position.y < 0:
		set_position(Vector2(position.x, window_height))
