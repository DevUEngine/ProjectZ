extends Node

func rand_in_circle(r: float) -> Vector2:
	var a = randf() * TAU
	var d = sqrt(randf()) * r
	return Vector2(cos(a) * d, sin(a) * d)

func distance(a: Node2D, b: Node2D) -> float:
	return a.global_position.distance_to(b.global_position)

func format_time(sec: int) -> String:
	var m = sec / 60
	var s = sec % 60
	return "%d:%02d" % [m, s]
