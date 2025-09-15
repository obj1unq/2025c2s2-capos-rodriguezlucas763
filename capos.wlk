object rolando {
    var property poderBase = 5 

    var property casa = castilloDePiedra

    var property mochila = #{} 
    var property espacioLimite = 2
    var property historiaDeArtefactos = []

    method validarEncontrarArtefacto(artefacto) {
        if (mochila.size() == espacioLimite) {
            self.error("La mochila está llena")
        }
    }
    method encontrarArtefacto(artefacto) {
        historiaDeArtefactos.add(artefacto)
        self.validarEncontrarArtefacto(artefacto)
        mochila.add(artefacto)
    }
    method volverAlCastillo() {
        casa.almacenarArtefactos(mochila)
        mochila.clear()
    }
    method verPosesiones() {
        return mochila + casa.coleccion()
    }
    method tengoElArtefacto(artefacto) {
        return self.verPosesiones().contains(artefacto)
      
    }
    method poderDePelea() {
        return poderBase + mochila.sum({artefacto => artefacto.poder(self)})
    }
    method pelearBatalla() {
        mochila.forEach({artefacto => artefacto.fueUsado()})
        poderBase += 1
    }
}

object castilloDePiedra {
    var property coleccion = #{}

    method almacenarArtefactos(artefactos) {
      coleccion.addAll(artefactos)
    }
}
object espadaDelDestino {
    var fueUsada = false

    method poder(portador) {
        if (fueUsada) {
            return portador.poderBase() * 0.5
        }
        else {
            return portador.poderBase()
        }
    }
    method fueUsado() {
        fueUsada = true
    }
}

object libroDeHechizos {
    
}

object collarDivino {
    var property vecesUsado = 0 
    const poderBasico = 3

    method poder(portador) {
        if (portador.poderBase() > 6) {
            return poderBasico + vecesUsado
        }
        else {
            return poderBasico
        }
    }
    method fueUsado() {
        vecesUsado += 1
    }
}

object armaduraDeAceroValyrio{

    method poder(portador) {
        return 6
    }
    method fueUsado() {

    }
}