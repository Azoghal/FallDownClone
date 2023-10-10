@tool
extends Node2D

signal landedOn(Node2D, int) 

@export_range(1, 100) var width = 5
var box_width
var level 
var particles = preload("res://particles.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	box_width = $Holder/Left.texture.get_width()
	
func initialise(pos: Vector2, width: int, level:int):
	# do other set up
	self.position = pos
	self.width = width
	self.level = level
	box_width = $Holder/Left.texture.get_width()
	setWidth(width)

func setStubby():
	$Holder/Stubby.visible = true
	$Holder/Left.visible = false
	$Holder/Middle.visible = false
	$Holder/Right.visible = false
	$Holder/StaticFloor.position = Vector2(0,0)
	
func setLR():
	$Holder/Stubby.visible = false
	$Holder/Left.visible = true
	$Holder/Middle.visible = false
	$Holder/Right.visible = true
	$Holder/StaticFloor.position = Vector2(box_width/2,0)
	$Holder/Right.position = Vector2(box_width, 0)
	
func setLMR(width: float):
	width -= 1
	$Holder/Stubby.visible = false
	$Holder/Left.visible = true
	$Holder/Middle.visible = true
	$Holder/Right.visible = true
	$Holder/Right.position = Vector2((width)*box_width, 0)
	$Holder/Middle.position = Vector2((width/2)*box_width, 0)
	$Holder/Middle.scale = Vector2(width-1,1)
	$Holder/StaticFloor.position = Vector2(((width)/2)*box_width,0)

func setWidth(width: int):
	$Holder/StaticFloor.scale = Vector2(width, 1)
	if width<=0:
		print("Boo not allowed 0 or negative width on floor")
	elif width ==1:
		setStubby()
	elif width == 2:
		setLR()
	else:
		setLMR(width)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Engine.is_editor_hint():
		setWidth(self.width)
	else:
		pass
 

func _on_top_area_body_entered(body):
	print("I'm level ", self.level)
	landedOn.emit(body, self.level)
	var p = particles.instantiate()
	p.emitting = true
	p.position = Vector2(0,-250)
#	p.position = self.position
	add_child(p)
	


func _on_landed_on(body, level):
	$AudioStreamPlayer.play()
	
