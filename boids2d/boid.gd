extends Polygon2D

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
func _process(delta):
	translate(velocity * get_meta("Speed"))
	if _out_of_screen_bounds():
		_navigate_to_other_side_of_screen()

func _navigate_to_other_side_of_screen():
	if position.x > screen_width:
		set_position(Vector2(0, position.y))
	elif position.x < 0:
		set_position(Vector2(screen_width, position.y))

	if position.y > screen_height:
		set_position(Vector2(position.x, 0))
	elif position.y < 0:
		set_position(Vector2(position.x, screen_height))

func _out_of_screen_bounds():
	return position.x > screen_width \
		|| position.x < 0 \
		|| position.y > screen_height \
		|| position.y < 0

func update_velocity(velocity: Vector2):
	self.velocity = velocity
	# Update model rotation to match the new flight direction
	rotate(velocity.angle() - deg_to_rad(90))
