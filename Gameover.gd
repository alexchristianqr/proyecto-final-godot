extends Area2D
signal reboot

func _ready():
	pass

# Emite una señal
func _on_Button_button_down():
	emit_signal("reboot")

# Señal que reinicia el juego
func _on_Gameover_reboot():
	get_tree().reload_current_scene()

# Naves Enemigas caidas
var deceso = 0
func contar_muertos():
	deceso = deceso + 1
	print(deceso, " kill")
	$Kills.text = str(deceso) # Enseña la cantidad de naves muertas

# Victoria
func label_ganaste():
	$Label.text = "Ganaste!"
