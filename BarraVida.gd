extends Node2D


export var originalX =1

# Called when the node enters the scene tree for the first time.
func _ready():
	originalX = $ColorRect.get_size().x

func _on_Player1_restar_vida():
	var dolor = originalX/9
	var newX = $ColorRect.get_size().x - dolor
	$ColorRect.set_size(Vector2(newX,$ColorRect.get_size().y))


func _on_Player2_restar_vida():
	var dolor = originalX/9
	var newX = $ColorRect.get_size().x - dolor
	$ColorRect.set_size(Vector2(newX,$ColorRect.get_size().y))
