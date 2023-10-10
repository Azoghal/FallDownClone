extends Control

var score = 0
var time_in_seconds = 0
var time_label: Label
var timer: Timer
var score_label: Label

# Called when the node enters the scene tree for the first time.
func _ready():
	self.time_label = $MarginContainer/VBoxContainer/time 
	self.timer = $MarginContainer/VBoxContainer/time/Timer
	self.score_label = $MarginContainer/VBoxContainer/score

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_score(new_score):
	score = new_score
	self.score_label.text = str(new_score)
	
func scored(score):
	if score > self.score:
		set_score(score)

func _on_timer_timeout():
	self.time_in_seconds += 1
	self.time_label.text = str(self.time_in_seconds)
	
func stop_score():
	self.timer.stop()
