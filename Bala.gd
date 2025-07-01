extends Area2D

@export var speed = 200

var screen_size
func _ready():
	screen_size = get_viewport_rect().size
	pass 

func _process(delta):
	movimiento_vertical(delta)
	pass

# Movimiento vertical de la bala
var y  = position.y
var velocidad
var distancia_frame
func movimiento_vertical(delta):
	velocidad = Vector2(0,0);
	velocidad.y = velocidad.y - 1
	
	velocidad = velocidad.normalized() * speed
	distancia_frame = velocidad * delta
	
	# Actualizar la position nave
	position = position + distancia_frame
	if (position.y <= 0):
		queue_free()

func _on_Bala_area_entered(area):
	area.queue_free()
	queue_free()
