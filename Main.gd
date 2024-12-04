extends Node
export var GameOver = false
#-------------------------------------------------------------------------------
# Intancio la escena Enemiga
var Enemys = load("res://Enemy.tscn")
#-------------------------------------------------------------------------------
func _ready():
	NuevosEnemys()
	$Gameover.hide()
	# Reproducir sonido
	var sonido_disparo = get_tree().get_root().get_node("Main/AudioStreamPlayer2D_Jugando")
	sonido_disparo.play()
#-------------------------------------------------------------------------------
func _process(delta):
	if (!GameOver):
		var NewPosition = $Player.MoverNave(delta)
		$Player.animatePlayer(NewPosition)

#-------------------------------------------------------------------------------
# Creando muchas naves
# Ancho de la nave : 67 pixeles
# Alto de la nave : 65
var y = 232#32 # La posición en y
var x = 67 # La posición en x
var i = 1  # Contador de las columna
var n = 1  # Contador de las  filas
func NuevosEnemys():
	while(n <= 4): #fila
		while(i <= 8): #columna
			var NewEnemy = Enemys.instance()
			NewEnemy.position = Vector2(x, y)
			#Tiene que haber espacio entre nave y nave: 767+10=77
			x = x + 77
			add_child(NewEnemy)
			i = i + 1
			
		get_tree().call_group('GroupEnemy', 'CambioDeNave')
		i = 1
		n = n + 1
		x = 67 
		y  -= 65
#-------------------------------------------------------------------------------
# Movimieno de Enemy ejecutando
func _on_Timer_timeout():
	get_tree().call_group('GroupEnemy', 'Mover')
#-------------------------------------------------------------------------------
# Coalición bala player con Enemy
func _on_Player_area_entered(_area):
	get_node("Timer").stop()
	pausarJuego()
	GameOver = true
	$Gameover.show()
#-------------------------------------------------------------------------------
# Creando muchas Balas Player
# Prints a random integer between 0 and 49.
func _input(event):
	if event is InputEventKey and event.pressed:
		if event.scancode == KEY_SPACE:
			$Player.Disparar()
#-------------------------------------------------------------------------------
# Función para pausar el juego
func pausarJuego():
	# Detener el sonido de disparo
	var sonido_disparo = get_tree().get_root().get_node("Main/AudioStreamPlayer2D_Jugando")
	sonido_disparo.stop()  # Detiene la reproducción del sonido	
#-------------------------------------------------------------------------------


