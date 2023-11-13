extends Node2D
var selected:bool = false
var restPoint
var restNodes = []
@export var index = 0
@export var color = 3
var uready:bool = false
var justSelected 
var prev
var oneToSelected
@export var monkr = Node2D
var collision = false
# Called when the node enters the scene tree for the first time.
func _ready():
	restNodes = get_tree().get_nodes_in_group("zone")
	restPoint = restNodes[index].global_position
	restNodes[0].select()


# Called every frame. 'delta' is the elapsed time since the previous frame.
	
	


func _on_area_2d_input_event(viewport, event, shape_idx):
	
	if Input.is_action_just_pressed("click") and not selected:
		if self.color == monkr.currentTurn:
			print("set")
			monkr.currentPeice = self
			selected = true
	elif Input.is_action_just_released("click", true):
		print("muaahaha")
		var shortestDist = 75
		prev = shortestDist
		for child in restNodes:
			var distance = global_position.distance_to(child.global_position)
			uready = true
			if true:
				if distance < shortestDist and not collision:
					restPoint = child.global_position
					shortestDist = distance
				elif distance < shortestDist and collision:
					restPoint = child.global_position
					shortestDist = distance
					monkr.currentPeiceToTake.queue_free()
					color = monkr.currentPeiceToTake.color
		selected = false
		if prev !=shortestDist and monkr.currentPeice == self:
			if monkr.currentTurn == 1:
				monkr.currentTurn = 0
			elif monkr.currentTurn == 0:
				monkr.currentTurn = 1
		prev = shortestDist
		print("Haha  ", color)

		
func _physics_process(delta):
	if selected:
		monkr.currentPeice = self
		global_position = lerp(global_position, get_global_mouse_position(), 25*delta)
		
	else:
		global_position = lerp(global_position, restPoint, 10*delta)
		
	
		#print("Me color is ", color)

func _on_area_2d_area_entered(area):
	if area.get_parent().index != null:
		if area.get_parent().color == monkr.currentTurn:
			if monkr.currentPeiceToTake != self and selected == false:
				if self.color != area.get_parent().color:
					collision = true
					monkr.currentPeiceToTake = self 
func _on_area_2d_area_exited(area):
	
	if area.get_parent().index != null:
		collision = false
