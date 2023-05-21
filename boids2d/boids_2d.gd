extends Node2D

var boid_scene = preload("res://boids2d/boid.tscn")
var flock = []

# Called when the node enters the scene tree for the first time.
func _ready():
	var size = get_window().size
	for i in range(150):
		var boid = boid_scene.instantiate()
		var initial_x = randf_range(0, size.x)
		var initial_y = randf_range(0, size.y)
		boid.set_position(Vector2(initial_x, initial_y))
		flock.append(boid)
		add_child(boid)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
