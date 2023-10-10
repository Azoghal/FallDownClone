extends Node2D

var level: int
@export var box_width: int = 500
@export var total_width: int = 25
@export var min_holes: int = 1
@export var max_holes: int = 4
@export var min_hole_width: int = 2
@export var max_hole_width: int = 6
var left:Vector2 = Vector2(-6000,0)
var floor = preload("res://Floor/floor.tscn")
var update_score: Callable

signal player_passed(int)

var colour_options = [Color.DARK_ORANGE, Color.ORCHID, Color.AQUA, Color.CHARTREUSE, Color.CORNFLOWER_BLUE, Color.GOLD, Color.ORANGE_RED, Color.RED]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	self.modulate = colour_options[randi_range(0, len(colour_options)-1)]
	
func create_floor(start:int, finish:int):
	var f = floor.instantiate()
	f.initialise(self.left+Vector2(start*500,0), finish-start+1, self.level)
	f.connect("landedOn", update_score)
	self.add_child(f)

func initialise(level:int, pos:Vector2):
	self.level = level
	self.position = pos
	var floor_mask = []
	for i in range(total_width):
		floor_mask.append(true)
		
	var num_holes = randi_range(min_holes, max_holes)
	for hole_num in num_holes:
		var hole_size = randi_range(min_hole_width, max_hole_width)
		var hole_location = randi_range(0, total_width)
		for i in range(hole_size):
			floor_mask[min(total_width-1,hole_location + i)] = false
	
	var building=  false 
	var start = 0
	var finish = 0
	for i in range(total_width):
		var m = floor_mask[i]
		if m and not building:
			start = i
			building = true
		if !m and building:
			finish = i-1
			building = false
			self.create_floor(start,finish)
	if building:
		finish = total_width-1
		self.create_floor(start,finish)
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
