import wollok.game.*
import personajes.*

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
	method palanca() = 7
	method paredBoss() = 8
	method espada() = 3000000
	method boton() = 9
	method nota() = 10
	method llave() = 11
	method caja() = 12
	method estatua() = 13
	method columnabot() = 14
	method gameOver() = 232323

}