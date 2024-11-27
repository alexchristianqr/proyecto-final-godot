extends Area2D


var screen_size

#-------------------------------------------------------------------------------
#Intancio la escena Bala Enemy
var BalaEnemys = load("res://BalaEnemy.tscn") #Nombre mal el name de la escena
#-------------------------------------------------------------------------------
func _ready():
	screen_size = get_viewport_rect().size
	# Añadir escena a un grupo
	add_to_group("GroupEnemy")

#-------------------------------------------------------------------------------
#crear balas Enemy
var Enemigo

func _on_TimeDisparo_timeout():
	Disparo()
#-------------------------------------------------------------------------------	
func Disparo():
	var main = get_tree().get_root().get_node('Main')
	if (!main.GameOver && (randi() % 100) <= 1): 
		var NewBalaEnemy = BalaEnemys.instance()
		#Tomamos la posición de Enemy
		NewBalaEnemy.position = Vector2(position.x, position.y)
		get_tree().get_root().get_node("Main").add_child(NewBalaEnemy)

	
#-------------------------------------------------------------------------------
#Mover nave Enemy
var i = 1 # I incrementa
var velocidad = Vector2(0,0);
#Tres movimientos de las naves
#Velocidad reemplaza a position
func Mover():
	match(i):
		1: #Movimiento a la derecha
			#print((position.x + 33) , " < ",(screen_size.x ))
			if ((position.x + 33)  < (screen_size.x)):
				position.x += 1;
			else:
				get_tree().call_group('GroupEnemy', 'Izquierda');
		2: #Movimiento a la izquierda
			if(position.x > 33):
				position.x -= 1;
			else:
				get_tree().call_group('GroupEnemy', 'Abajo');
		3: #Movimento vertical abajo
			#65 por el alto de la nave y 32 para que decienda la mitad y choque
			if((position.y + 65) < screen_size.y):
				#position.y += 64;
				position.y += 65;
				get_tree().call_group('GroupEnemy', 'Derecha');
				
	return position
#-------------------------------------------------------------------------------
#Cambiar dirección del movimiento
func Izquierda():
	i=2;
func Abajo():
	i=3
func Derecha():
	i=1
#-------------------------------------------------------------------------------
#Cambiar el color de las naves
var e = 0
var mob_types
var n = 2
var nn = 1
func CambioDeNave():
	mob_types = $AnimatedSprite.frames.get_animation_names()
	match(nn):
		1:
			$AnimatedSprite.animation = mob_types[n]
			n = n - 1
			nn = 2
		2:
			$AnimatedSprite.animation = mob_types[n]
			n = n - 1
			nn = 3
		3:
			$AnimatedSprite.animation = mob_types[n]
			#n = 1
			nn = 3

#-------------------------------------------------------------------------------
#Naves caidas
var EnemyLista
func _on_Enemy_area_entered(_area):
	#get_tree().get_root().get_node("Main").KillCounter()
	get_tree().get_root().get_node("Main/Gameover").KillCounter()
	#get_tree().get_root().get_node("Main/Gameover").Ganaste()
	
	EnemyLista = get_tree().get_nodes_in_group("GroupEnemy")
	print(EnemyLista.size())
	if(EnemyLista.size() == 1):
		get_tree().get_root().get_node("Main/Gameover").show()
		get_tree().get_root().get_node("Main/Gameover").Ganaste()
		print("Cualquier cosa")
		#$Label.text = "Victory"
	
