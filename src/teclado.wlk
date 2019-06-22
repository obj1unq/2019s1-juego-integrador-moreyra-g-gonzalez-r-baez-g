import wollok.game.*
import jugador.*
import direcciones.*
import gameOver.*

object teclado {
	
	method activar(){
	keyboard.up().onPressDo { jugador.mover(direccionRep.arriba()) }
	keyboard.down().onPressDo { jugador.mover(direccionRep.abajo()) }
	keyboard.left().onPressDo { jugador.mover(direccionRep.izquierda()) }
	keyboard.right().onPressDo { jugador.mover(direccionRep.derecha()) }


	keyboard.z().onPressDo {jugador.atacar()}
	keyboard.x().onPressDo {jugador.defender()}
	keyboard.c().onPressDo {jugador.interactuar()}

	keyboard.r().onPressDo	{gameOver.continuar()} //de prueba
	}
	
}
