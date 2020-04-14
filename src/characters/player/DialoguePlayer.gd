extends Node

func _on_Player_start_convo():
	var dialoguePanel = load("res://src/GUI/dialogue/DialoguePanel.tscn").instance()
	var world = get_tree().current_scene
	world.add_child(dialoguePanel)
	world.get_node("DialoguePanel").connect("convo_end", self, "_on_ConvoEnd")

func _on_ConvoEnd():
	get_tree().current_scene.get_node("DialoguePanel").queue_free()