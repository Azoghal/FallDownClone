extends Node2D

var player = preload("res://player.tscn")
var camera = preload("res://falldownCamera.tscn")
var level_generator = preload("res://level_generator.tscn")
var pause_menu
var gameover_menu
var gui

# Called when the node enters the scene tree for the first time.
func _ready():
	var c = camera.instantiate()
	add_child(c)
	var p = player.instantiate()
	p.position = $PlayerSpawn.position
	add_child(p)
	c.target = p
	c.connect("killed_player", p.death_sequence)
	var lg = level_generator.instantiate()
	add_child(lg)
	lg.position = $PlayerSpawn.position + Vector2.DOWN*1500
	lg.begin_generation()
	pause_menu = get_parent().get_node("CanvasLayer/pause")
	gameover_menu = get_parent().get_node("CanvasLayer/Gameover")
	gui = get_parent().get_node("CanvasLayer/GUI")
	c.connect("killed_player", gameover_menu.show_gameover)
	c.connect("killed_player", gui.stop_score)
	lg.connect("scored", gui.scored)
	lg.connect("scored", gameover_menu.scored)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func pause():
	if pause_menu:
		pause_menu.show_menu()
		get_tree().paused = true

func _unhandled_input(event):
	if event.is_action_pressed("Escape"):
		pause()

func _on_audio_stream_player_2d_finished():
	$AudioStreamPlayer.play()
