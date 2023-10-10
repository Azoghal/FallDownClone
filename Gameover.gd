extends Control


var score
# Called when the node enters the scene tree for the first time.
func _ready():
	self.score = 0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func show_gameover():
	self.visible = true
	
func scored(score):
	self.score = max(score, self.score)
	$VBoxContainer/Score.text = str(self.score)

func _on_restart_button_down():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://main.tscn")


func _on_main_menu_button_down():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://menu.tscn")


func _on_quit_button_down():
	get_tree().quit()
