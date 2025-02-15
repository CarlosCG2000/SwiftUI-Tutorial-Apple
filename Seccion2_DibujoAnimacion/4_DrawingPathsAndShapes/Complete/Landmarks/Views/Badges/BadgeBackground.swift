/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view that displays the background of a badge.
*/

import SwiftUI

// Dibuja el fondo de la insignia con forma de hexágono.
struct BadgeBackground: View {
    
    static let gradientStart = Color(red: 239.0 / 255, green: 120.0 / 255, blue: 221.0 / 255)
    static let gradientEnd = Color(red: 239.0 / 255, green: 172.0 / 255, blue: 120.0 / 255)
    
    var body: some View {
        
        GeometryReader { geometry in // Use GeometryReader para obtener el tamaño de la vista y ajustar el hexágono en consecuencia.
            
            Path { path in // Cree un camino para el hexágono.
                
                // Agregue un punto de partida a la ruta, suponiendo un contenedor con un tamaño de 100 x 100 px.
                var width = min(geometry.size.width, geometry.size.height)
                let height = width
                
                // Escale la forma en el eje x usando
                let xScale: CGFloat = 0.832
                let xOffset = (width * (1.0 - xScale)) / 2.0
                width *= xScale

                path.move( // Mueve el punto de inicio a la primera coordenada.
                    to: CGPoint(
                        x: width * 0.95 + xOffset,
                        y: height * (0.20 + HexagonParameters.adjustment)
                    )
                )
                //__________________________

                // Agregue los segmentos a la ruta.
                HexagonParameters.segments.forEach { segment in
                    path.addLine( // Dibuja una línea recta hasta el siguiente punto.
                        to: CGPoint(
                            x: width * segment.line.x + xOffset,
                            y: height * segment.line.y
                        )
                    )

                    path.addQuadCurve( // Agrega una curva cuadrática con un punto de control.
                        to: CGPoint(
                            x: width * segment.curve.x + xOffset,
                            y: height * segment.curve.y
                        ),
                        control: CGPoint(
                            x: width * segment.control.x + xOffset,
                            y: height * segment.control.y
                        )
                    )
                }
            }
            // Fondo degradado del hexágono, dado al Path
            .fill(
                .linearGradient (
                Gradient(colors: [Self.gradientStart, Self.gradientEnd]),
                startPoint: UnitPoint(x: 0.5, y: 0),
                endPoint: UnitPoint(x: 0.5, y: 0.6)
                )
            )
            
        }
        // Escalado de la vista para que se ajuste al contenedor.
        .aspectRatio(1, contentMode: .fit)
    }
    

}

#Preview {
    BadgeBackground()
}
