import wollok.game.*
import jugador.*
import mapas.*
import colisiones.*
import cosas.*
import teclado.*

object gameOver {
	method position() = game.at(3,6)
	method image() = "gameOver.png"
	method id() = 232323
	
	method finDelJuego(){
		game.addVisual(self)
	}
	method continuar(){
		if(not jugador.estaVivo()){
			game.clear()
			sala_2.cargarMapa()
			teclado.activar()
			agregarColisiones.jugador()
			jugador.estaVivo(true)
			jugador.position(game.at(1,13))
			boss.regenerar()
		}
	}
	method chochar(){/*no hace nada*/}
}
