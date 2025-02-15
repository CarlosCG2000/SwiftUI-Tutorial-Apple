/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view that displays a badge.
*/

import SwiftUI

struct Badge: View {
    
    var badgeSymbols: some View {
        
        // 8 veces el símbolo del distintivo, cada uno rotado 45 grados.
        ForEach(0..<8) { index in
            
            RotatedBadgeSymbol(
                angle: .degrees(Double(index) / Double(8)) * 360.0 // 45 grados
            )
        }
        .opacity(0.5) // Reduce la opacidad para un efecto visual.
    }

    var body: some View {
        
        ZStack {
            
            BadgeBackground() // fondo hexagonal con curvas de Bézier

            // Coloque los símbolos del distintivo en la parte superior del fondo hexagonal
            GeometryReader { geometry in
                badgeSymbols // 8 símbolos del distintivo, con rotación
                    .scaleEffect(1.0 / 4.0, anchor: .top) // Escala los símbolos.
                    .position(x: geometry.size.width / 2.0, y: (3.0 / 4.0) * geometry.size.height) // Ubica los símbolos en el hexágono.
            }
        }
        .scaledToFit()
        
        
        
        
        // EJEMPLO DE PATH
        HStack {
            
            Path { path in
                
                path.move(to: CGPoint(x: 20, y: 0)) // punto de inicio (desde aqui)
                
                path.addLine(to: CGPoint(x: 20, y: 200)) // línea vertical (desde aqui sigue)
             
                path.addLine(to: CGPoint(x: 220, y: 200)) // línea horizontal (desde aqui sigue)
                
                path.addLine(to: CGPoint(x: 220, y: 0)) // línea vertical (desde aqui sigue)
                
                // Lado superior con curva en la esquina superior izquierda
                path.addLine(to: CGPoint(x: 40, y: 0))
                path.addQuadCurve(to: CGPoint(x: 20, y: 20), control: CGPoint(x: 20, y: 0)) // control: punto de control de la curva
                
                // No se cierra explícitamente con closeSubpath(), pero el relleno lo cubre y parece que se cierra
                //path.closeSubpath()
                
                // path.addLine(to: CGPoint(x:0, y: -40)) // prueba
            }
            .fill(
                .linearGradient(
                    Gradient(colors: [.green, .blue]),
                    startPoint: .init(x: 0.5, y: 0),
                    endPoint: .init(x: 0.5, y: 0.5)
                )
            )
            .frame(width: 200, height: 200) // Le damos tamaño al Path
    
        }
        .background(.gray) // Vemos como parte desde la x en 20 el path
    }
}

#Preview {
    Badge()
}
