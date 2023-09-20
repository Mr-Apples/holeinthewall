extends Node2D

# Load game when play button is pressed
func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://world.tscn")


# Quit game when quit button is pressed
func _on_quit_button_pressed():
	get_tree().quit()

func _ready():
	get_node("Label").text = "Score: " + str(GlobalVars.score)
