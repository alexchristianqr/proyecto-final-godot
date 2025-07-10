extends Node
@export var GameOver = false

# Intancio la escena Enemiga
var Enemigo = load("res://Enemigo.tscn")

func _ready():
	nuevos_enemigos()
	
	$Gameover.hide()  # Ocultar variable
	
	# Reproducir sonido
	var sonido_disparo = get_tree().get_root().get_node("Main/AudioStreamPlayer2D_Jugando")
	sonido_disparo.play()

func _process(delta):
	if (!GameOver):
		var nueva_posicion = $Player.mover_nave(delta)
		$Player.animar_jugador(nueva_posicion)

# Creando muchas naves
# Ancho de la nave : 67 pixeles
# Alto de la nave : 65
var y = 232#32 # La posición en y     
var x = 67 # La posición en x
var i = 1  # Contador de las columna
var n = 1  # Contador de las  filas

func nuevos_enemigos():
	while(n <= 4): #fila
		while(i <= 8): #columna
			var nuevo_enemigo = Enemigo.instantiate()
			
			# La posición del enemigo
			nuevo_enemigo.position = Vector2(x, y)
			
			# Tiene que haber espacio entre nave y nave: 767+10=77
			x = x + 77
			add_child(nuevo_enemigo)
			i = i + 1
			
		get_tree().call_group('GroupEnemy', 'cambiar_nave')
		i = 1
		n = n + 1
		x = 67 
		y  -= 65

# Movimieno de Enemy ejecutando
func _on_Timer_timeout():
	get_tree().call_group('GroupEnemy', 'mover_nave')

# Coalición bala player con Enemy
func _on_Player_area_entered(_area):
	get_node("Timer").stop()
	pausar_juego()
	GameOver = true
	$Gameover.show()

# Creando muchas Balas Player
# Prints a random integer between 0 and 49.
func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_SPACE:
			$Player.disparar()

# Función para pausar el juego
func pausar_juego():
	# Detener el sonido de disparo
	var sonido_disparo = get_tree().get_root().get_node("Main/AudioStreamPlayer2D_Jugando")
	
	# Detiene la reproducción del sonido	
	sonido_disparo.stop()
