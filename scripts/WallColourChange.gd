extends MeshInstance3D

var material = StandardMaterial3D.new()

func _ready():
	var color_r = randf_range(0, 1)
	var color_g = randf_range(0, 1)
	var color_b = randf_range(0, 1)
	var color_a = randf_range(0, 1)

	material.albedo_color = Color(color_r, color_g, color_b, color_a)
	mesh.surface_set_material(0, material)
