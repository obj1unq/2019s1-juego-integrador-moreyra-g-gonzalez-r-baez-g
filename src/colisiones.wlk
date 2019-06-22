import wollok.game.*
import jugador.*

object agregarColisiones {
	
	method jugador(){
		game.whenCollideDo(jugador, { objetoX => objetoX.chocar() })
	}
	
}

object id {
	method puerta() = 2
	method pared() = 1
	method pepita() = 3
	method jugador() = 4
	method roca() = 5
	method sueloRoca() = 6
	method espada() = 3000000

}