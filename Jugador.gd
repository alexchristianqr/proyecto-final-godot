extends Area2D

@export var speed = 300

# Intanciar la escena Bala player
var Bala = load("res://Bala.tscn")

# Variable que obtine el tamaño de la pantalla
var screen_size
func _ready():
	screen_size = get_viewport_rect().size
	pass

# Movimiento de Player
# Utilisado en godot para normalisar movimiento quaternion, usado tambien en la
# función normalizad
var distanciaFrame
var velocidad

func mover_nave(delta):
	velocidad = Vector2(0,0);
	
	if(Input.is_action_pressed("ui_right")):
		velocidad.x = velocidad.x + 1
		
	if(Input.is_action_pressed("ui_left")):
		velocidad.x = velocidad.x - 1
		
	if(Input.is_action_pressed("ui_up")):
		velocidad.y = velocidad.y - 1
		
	if(Input.is_action_pressed("ui_down")):
		velocidad.y = velocidad.y + 1
		
	velocidad = velocidad.normalized() * speed
	distanciaFrame = velocidad * delta
	
	# Actualizar la pocsition nave
	position = position + distanciaFrame
	
	# Postion actual Min y Max
	position.x = clamp(position.x, 33, screen_size.x-33)
	return position.x

# Animación del player
func animar_jugador(posicion_jugador):
	
	if(Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_left")):
		$AnimatedSprite2D.play()
		$AnimatedSprite2D.animation = "Move"
		
	else:
		$AnimatedSprite2D.stop()
		$AnimatedSprite2D.animation = "Still"
		
	if((posicion_jugador == screen_size.x-33) or posicion_jugador == 33):
		#print(positonPlayer, "    Hola")
		$AnimatedSprite2D.stop()
		$AnimatedSprite2D.animation = "Still"

# Creando muchas Balas Player
func disparar():
	var main = get_tree().get_root().get_node('Main')
	if (!main.GameOver):
		var nueva_bala = Bala.instantiate()
		
		nueva_bala.position = Vector2(position.x,position.y-32)
		get_tree().get_root().get_node("Main").add_child(nueva_bala)
		
		# Reproducir sonido
		var sonido_disparo = get_tree().get_root().get_node("Main/AudioStreamPlayer2D_Bala")
		sonido_disparo.play()
