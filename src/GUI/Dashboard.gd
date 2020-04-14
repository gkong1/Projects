extends Control

func _on_InventoryButton_pressed():
	var inventorypanel = load("res://src/GUI/inventory/Inventory.tscn").instance()
	add_child(inventorypanel)
#	get_node("Inventory").connect("close_inv_panel", self, "_on_CloseInvPanel")

func _on_Player_start_convo(colliding_name):
	get_tree().paused = true
	var dialoguepanel = load("res://src/GUI/dialogue/DialoguePanel.tscn").instance()
#	get_parent().add_child(dialoguepanel)
	add_child(dialoguepanel)
#
#func _on_DialoguePanel_convo_end():
#
#	get_tree().paused = false
