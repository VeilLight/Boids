extends Polygon2D

var max_width = 0
var max_height = 0
var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	max_width = get_window().size.x
	# Choose a random direction to start flying into
	var angle = randf_range(0, 2 * PI)
	update_velocity(Vector2(cos(angle), sin(angle)))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	translate(velocity)
	_limit_velocity()
	_update_rotation()
	_update_bounds()

func setup(_initial_position: Vector2, _max_height: int):
	set_position(_initial_position)
	max_height = _max_height

func update_velocity(_velocity: Vector2):
	velocity += _velocity

func get_velocity():
	return velocity

func _update_rotation():
	# Update model rotation to match the flight direction
	set_rotation(velocity.angle() + deg_to_rad(90))

func _limit_velocity():
	# Limit speed between a minimum and maximum
	var velocity_magnitude = velocity.length()
	var speed = max(min(velocity_magnitude, get_meta("max_speed")), get_meta("min_speed"))
	velocity = velocity / velocity_magnitude * speed
	
func _update_bounds():
	var screen_margin = get_meta("screen_margin")
	if screen_margin > 0:
		_stay_within_scree_bounds(screen_margin)
	else:
		_navigate_to_other_side_of_screen_if_out_of_bounds()

func _stay_within_scree_bounds(screen_margin: float):
	var turn_factor = get_meta("turn_factor")
	
	if position.x < screen_margin:
		velocity.x += turn_factor
	elif position.x > max_width - screen_margin:
		velocity.x -= turn_factor
	
	if position.y < screen_margin:
		velocity.y += turn_factor
	elif position.y > max_height - screen_margin:
		velocity.y -= turn_factor

func _navigate_to_other_side_of_screen_if_out_of_bounds():
	if position.x > max_width:
		set_position(Vector2(0, position.y))
	elif position.x < 0:
		set_position(Vector2(max_width, position.y))
	if position.y > max_height:
		set_position(Vector2(position.x, 0))
	elif position.y < 0:
		set_position(Vector2(position.x, max_height))
