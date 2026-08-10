extends StaticBody2D
var pos
@export var door: NodePath
@export var door2: NodePath
@export var door3: NodePath
@export var door4: NodePath
@export var door5: NodePath
@export var door6: NodePath
@export var door7: NodePath
func _ready() -> void:
	pos = Vector2(round(position.x/32) * 32 +16, round(position.y/32)*32-16)
	self.position = pos


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("player") or area.is_in_group("clone"):
		Sfx.keys()
		var doorn = get_node_or_null(door)
		var doorn2 = get_node_or_null(door2)
		var doorn3 = get_node_or_null(door3)
		var doorn4 = get_node_or_null(door4)
		var doorn5 = get_node_or_null(door5)
		var doorn6 = get_node_or_null(door6)
		var doorn7 = get_node_or_null(door7)
		if doorn != null:
			doorn.unlock()
		if doorn2 != null:
			doorn2.unlock()
		if doorn3 != null:
			doorn3.unlock()
		if doorn4 != null:
			doorn4.unlock()
		if doorn5 != null:
			doorn5.unlock()
		if doorn6 != null:
			doorn6.unlock()
		if doorn7 != null:
			doorn7.unlock()
		self.hide()
