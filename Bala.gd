extends Area2D

export var speed = 200
var screen_size
#-------------------------------------------------------------------------------
func _ready():
	screen_size = get_viewport_rect().size
pass 

#-------------------------------------------------------------------------------
func _process(delta):
	VerticalMovement(delta)
	pass
#-------------------------------------------------------------------------------
#Movimiento vertical de la bala
var y  = position.y
var velocidad
var distanciaFrame
func VerticalMovement(delta):
	velocidad = Vector2(0,0);
	velocidad.y = velocidad.y - 1
	velocidad = velocidad.normalized() * speed
	distanciaFrame = velocidad * delta
	#actualsar la pocsition nave
	position = position + distanciaFrame
	if (position.y <= 0):
		queue_free()
	#queue_free()
	#hide()
	
#-------------------------------------------------------------------------------
func _on_Bala_area_entered(area):
	area.queue_free()
	queue_free()
