import wollok.game.*
import personajes.*
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

object final{
	var property image = "cielo.png"
	method position()= game.at(0,0)
	
	method ganaste(){
		
		game.onTick(2000,"espera",{
			game.clear()
			game.addVisual(self)
			self.cambio() 
			})
	}
	method cambio(){
		game.onTick(500,"cielo",{image="cielo2.png"game.removeTickEvent("cielo")})
		game.onTick(1000,"cielo2",{image="cielo.png"game.removeTickEvent("cielo2") self.cambio()})
	}
}



