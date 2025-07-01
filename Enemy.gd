extends Area2D

var screen_size

# Intanciar la escena Bala Enemy
var BalaEnemigo = load("res://BalaEnemy.tscn") #Nombre mal el name de la escena

# 
func _ready():
	screen_size = get_viewport_rect().size
	# Añadir escena a un grupo
	add_to_group("GroupEnemy")

# Crear balas Enemy
var Enemigo

func _on_TimeDisparo_timeout():
	disparar()
	
func disparar():
	var main = get_tree().get_root().get_node('Main')
	
	if (!main.GameOver && (randi() % 100) <= 1): 
		var nueva_bala = BalaEnemigo.instantiate()
		#Tomamos la posición de Enemy
		nueva_bala.position = Vector2(position.x, position.y)
		get_tree().get_root().get_node("Main").add_child(nueva_bala)

# Mover nave Enemy
var i = 1 # I incrementa
var velocidad = Vector2(0,0);

# Tres movimientos de las naves
# Velocidad reemplaza a position
func mover_nave():
	match(i):
		1: # Movimiento a la derecha
			if ((position.x + 33)  < (screen_size.x)):
				position.x += 1;
			else:
				get_tree().call_group('GroupEnemy', 'mover_izquierda');
		2: # Movimiento a la izquierda
			if(position.x > 33):
				position.x -= 1;
			else:
				get_tree().call_group('GroupEnemy', 'mover_abajo');
		3: # Movimento vertical abajo
		   # 65 por el alto de la nave y 32 para que decienda la mitad y choque
			if((position.y + 65) < screen_size.y):
				position.y += 65;
				get_tree().call_group('GroupEnemy', 'mover_derecha');
				
	return position

# Cambiar dirección del movimiento
func mover_izquierda():
	i=2;
	
func mover_abajo():
	i=3;
	
func mover_derecha():
	i=1

# Cambiar el color de las naves
var e = 0
var mob_types
var n = 2
var nn = 1

func cambiar_nave():
	mob_types = $AnimatedSprite2D.sprite_frames.get_animation_names()

	match(nn):
		1:
			$AnimatedSprite2D.animation = mob_types[n]
			n = n - 1
			nn = 2
		2:
			$AnimatedSprite2D.animation = mob_types[n]
			n = n - 1
			nn = 3
		3:
			$AnimatedSprite2D.animation = mob_types[n]
			nn = 3

#Naves caidas
var EnemyLista

func _on_Enemy_area_entered(_area):
	get_tree().get_root().get_node("Main/Gameover").KillCounter()
	
	EnemyLista = get_tree().get_nodes_in_group("GroupEnemy")
	print(EnemyLista.size())
	
	if(EnemyLista.size() == 1):
		get_tree().get_root().get_node("Main/Gameover").show()
		get_tree().get_root().get_node("Main/Gameover").Ganaste()
		print("Cualquier cosa")
