extends Node2D
var boxPosition
func _on_spawn_timer_timeout():
	var box = preload("res://ItemBox/box.tscn")
	var insantiatedBox = box.instantiate()
	%SpawnTimer.wait_time = randi_range(3, 6)
	get_tree().root.get_child(1).add_child(insantiatedBox)
	
	#Spawn the box in of four positions:
	boxPosition = randi_range(1,4)
	match boxPosition:
		1:
			insantiatedBox.global_position = %Pipe1.global_position
		2:
			insantiatedBox.global_position = %Pipe2.global_position
		3:
			insantiatedBox.global_position = %Pipe3.global_position
		4:
			insantiatedBox.global_position = %Pipe4.global_position
	
