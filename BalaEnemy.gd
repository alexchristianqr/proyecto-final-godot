extends Area2D

@export var speed = 200

var screen_size
func _ready():
	screen_size = get_viewport_rect().size
	pass

func _process(delta):
	movimiento_abajo_vertical(delta)
	pass

# Movimiento vertical abajo de la bala player
var y  = position.y
var velocidad
var distanciaFrame

func movimiento_abajo_vertical(delta):
	velocidad = Vector2(0,0);
	velocidad.y = velocidad.y + 1
	velocidad = velocidad.normalized() * speed
	distanciaFrame = velocidad * delta
	
	# actualizar la pocsition nave
	position = position + distanciaFrame
	if (position.y >= screen_size.y):
		queue_free()
