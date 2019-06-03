import wollok.game.*
import jugador.*

object agregarColisiones {
	
	method jugador(){
		game.whenCollideDo(jugador, { objetoX => objetoX.chocar() })
	}
	
}
