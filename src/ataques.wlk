import wollok.game.*
import jugador.*
import mapas.*
import colisiones.*
import direcciones.*

class RondaDeAtaques {
	const property ataques = []
	method lanzarAtaque(sala){
		ataques.forEach({ataque => ataque.lanzarAtaque(sala)})
	}
}
 class Ataque{
 	var property position
 	var property image = "1.png"
 	method esTraspasable()=true
 	method chocar(){}
 	method lanzarAtaque(sala){
 		if(sala == sala_3){
 			game.addVisual(self)
 			game.onTick(10000,"incendiar",{
				self.cambiarAFuego()
				game.removeTickEvent("incendiar")
			})
 		}
 	}
 	method cambiarAFuego(){
		 self.image("2.png")
		 game.onTick(10000,"sacar alarma",{
		 	game.removeVisual(self)
		 	game.removeTickEvent("sacar alarma")
		 })
	}
 }