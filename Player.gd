extends Area2D
# Speed = Velocidad en ingles
export var speed = 300

#-------------------------------------------------------------------------------
# Intanciar la escena Bala player
var Balas = load("res://Bala.tscn")
var Sounds = load("res://Sounds")
#-------------------------------------------------------------------------------
# Variable que obtine el tamaño de la pantalla
var screen_size
func _ready():
	screen_size = get_viewport_rect().size
	pass
#-------------------------------------------------------------------------------
# Movimiento de Player
# Utilisado en godot para normalisar movimiento quaternion, usado tambien en la
# función normalizad
var distanciaFrame
var velocidad
func MoverNave(delta):
	velocidad = Vector2(0,0);
	if(Input.is_action_pressed("ui_right")):
		velocidad.x = velocidad.x + 1
		
	if(Input.is_action_pressed("ui_left")):
		velocidad.x = velocidad.x - 1
		
	velocidad = velocidad.normalized() * speed
	distanciaFrame = velocidad * delta
	# actualizar la pocsition nave
	position = position + distanciaFrame
	#               postion acutal       Min      Max
	position.x = clamp(position.x, 33, screen_size.x-33)
	return position.x
#-------------------------------------------------------------------------------
#Animación del player
func animatePlayer(positonPlayer):
	
	if(Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_left")):
		$AnimatedSprite.play()
		$AnimatedSprite.animation = "Move"
		
	else:
		$AnimatedSprite.stop()
		$AnimatedSprite.animation = "Still"
		
	if((positonPlayer == screen_size.x-33) or positonPlayer == 33):
		#print(positonPlayer, "    Hola")
		$AnimatedSprite.stop()
		$AnimatedSprite.animation = "Still"
		
#-------------------------------------------------------------------------------
# Creando muchas Balas Player
func Disparar():
	var main = get_tree().get_root().get_node('Main')
	if (!main.GameOver):
		var NewBalita = Balas.instance()
		NewBalita.position = Vector2(position.x,position.y-32)
		get_tree().get_root().get_node("Main").add_child(NewBalita)
		
		# Reproducir sonido
		var sonido_disparo = get_tree().get_root().get_node("Main/AudioStreamPlayer2D_Bala")
		sonido_disparo.play()
	
	

#-------------------------------------------------------------------------------

