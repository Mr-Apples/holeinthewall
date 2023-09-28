extends Label

func _ready():
	text = "0"

func _process(delta):
	text = str(GlobalVars.score)
