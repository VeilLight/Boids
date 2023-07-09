## Boids
Boids is an algorithm that simulates the behaviour of flocks, herds, and schools developed 
by [Craig Reynolds in 1987](http://www.red3d.com/cwr/papers/1987/boids.html).

As a way to experiment with Godot Engine, this project implements [Craig's algorithm](http://www.red3d.com/cwr/boids/)
in [Godot 4](https://godotengine.org/) by visualizing it in 2D.

## How it works

Craig Reynolds uses 3 simple rules to define the boids' behaviours:
- **Separation**: move away from nearby neighbours to avoid collisions
- **Alignment**: move towards the average steering direction of nearby neighbours
- **Cohesion**: move towards the average positions of nearby neighbours

## Usage
You can play around with the various parameters and see how they affect the flocking
behaviour by downloading and running the Microsoft Windows version of [Boids
 in the "App" folder]().

If you want to check and edit the code, don't forget to install Godot's engine version 4.

## Improvements

- Go 3D! Currently, all vectors are Vector2D. They can be changed to Vector3D and all 
current calculations will still apply. Also, changing to a 3D scene with a simple pyramid
or cone as the boids' geometry should do the trick!


- All boids are naively checking all other boids in the screen when calculations the
Separation, Alignment and Cohesion parameters. While this is not a problem with a small
number of boids in the screen, bigger flock numbers can slow down the visualization. Implementing
strategies like [K-D Trees](https://en.wikipedia.org/wiki/K-d_tree) would restrict each boids' queries 
to the nearest neighbours.

## License
This project is released under the [MIT License]().
