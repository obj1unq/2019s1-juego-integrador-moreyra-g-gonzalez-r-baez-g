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


object cosasLocas{
	var property listaLoca = [1,2,3,4,5,6,7,8,9,10]
	
	method metodoLoco(){ return listaLoca.removeAllSuchThat{elemento => elemento % 2 == 0}  }
}