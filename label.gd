extends Label

func _ready():
	text = "0"

func _on_wall_player_scored(score):
	text = str(score)
