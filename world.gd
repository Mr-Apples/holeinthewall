extends Node2D

func _on_wall_died():
	get_tree().change_scene_to_file("res://main.tscn")
