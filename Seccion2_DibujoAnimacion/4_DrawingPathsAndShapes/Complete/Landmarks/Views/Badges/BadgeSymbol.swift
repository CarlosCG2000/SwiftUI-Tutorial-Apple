/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view that display a symbol in a badge.
*/

import SwiftUI

// Dibuja la figura en el interior del hexágono.
struct BadgeSymbol: View {
    
    static let symbolColor = Color(red: 79.0 / 255, green: 79.0 / 255, blue: 191.0 / 255)

    var body: some View {
        
        GeometryReader { geometry in
            
            Path { path in
                let width = min(geometry.size.width, geometry.size.height)
                let height = width * 0.75
                let spacing = width * 0.030
                let middle = width * 0.5
                let topWidth = width * 0.226
                let topHeight = height * 0.488

                //  ________ PARTE SUPERIOR DEL SÍMBOLO ________
                path.addLines([ // Dibuja líneas para formar el símbolo en la parte superior.
                    CGPoint(x: middle, y: spacing),
                    CGPoint(x: middle - topWidth, y: topHeight - spacing),
                    CGPoint(x: middle, y: topHeight / 2 + spacing),
                    CGPoint(x: middle + topWidth, y: topHeight - spacing),
                    CGPoint(x: middle, y: spacing)
                ])

                // ________ PARTE INFERIOR DEL SÍMBOLO ________
                path.move(to: CGPoint(x: middle, y: topHeight / 2 + spacing * 3)) // Crea la parte inferior del símbolo.
                
                path.addLines([ // Crea la parte inferior del símbolo.
                    CGPoint(x: middle - topWidth, y: topHeight + spacing),
                    CGPoint(x: spacing, y: height - spacing),
                    CGPoint(x: width - spacing, y: height - spacing),
                    CGPoint(x: middle + topWidth, y: topHeight + spacing),
                    CGPoint(x: middle, y: topHeight / 2 + spacing * 3)
                ])
                // ________________________________________________
            }
            .fill(Self.symbolColor)
        }
        
    }
}

#Preview {
    BadgeSymbol()
}
