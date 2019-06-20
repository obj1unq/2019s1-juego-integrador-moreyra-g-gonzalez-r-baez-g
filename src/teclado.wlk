import wollok.game.*
import jugador.*
import direcciones.*
import gameOver.*

object teclado {
	
	method activar(){
	keyboard.up().onPressDo { jugador.mover(direccion.arriba()) }
	keyboard.down().onPressDo { jugador.mover(direccion.abajo()) }
	keyboard.left().onPressDo { jugador.mover(direccion.izquierda()) }
	keyboard.right().onPressDo { jugador.mover(direccion.derecha()) }


	keyboard.z().onPressDo {jugador.atacar()}
	keyboard.x().onPressDo {jugador.defender()}
	keyboard.c().onPressDo {jugador.interactuar()}

	keyboard.r().onPressDo	{gameOver.continuar()} //de prueba
	}
	
}
