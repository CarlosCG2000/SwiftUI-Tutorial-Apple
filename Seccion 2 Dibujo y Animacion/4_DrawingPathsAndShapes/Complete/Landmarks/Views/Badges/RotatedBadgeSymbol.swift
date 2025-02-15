/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view that displays a rotated version of a badge symbol.
*/

import SwiftUI

// Crea una versión rotada del BadgeSymbol.
struct RotatedBadgeSymbol: View {
    
    let angle: Angle // Ángulo de rotación del símbolo del distintivo.

    var body: some View {
        
        BadgeSymbol()
            .padding(-60)
            .rotationEffect(angle, anchor: .bottom) // Gire el símbolo del distintivo alrededor de su punto de anclaje inferior.
    }
}

#Preview {
    RotatedBadgeSymbol(angle: Angle(degrees: 5))
}
