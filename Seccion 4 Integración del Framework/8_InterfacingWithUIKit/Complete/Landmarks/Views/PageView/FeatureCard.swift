/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view that shows a featured landmark.
*/

import SwiftUI

// Incluya el modificador de relación de aspecto para que imite la relación de aspecto de la vista donde eventualmente previsualizará
struct FeatureCard: View {
    
    var landmark: Landmark

    var body: some View {
        landmark.featureImage?
            .resizable()
            .overlay { // Superponer información de texto sobre el punto de referencia en la imagen.
                TextOverlay(landmark: landmark)
            }
    }
}

struct TextOverlay: View {
    
    var landmark: Landmark

    var gradient: LinearGradient {
        .linearGradient(
            Gradient(colors: [.black.opacity(0.6), .black.opacity(0)]),
            startPoint: .bottom,
            endPoint: .center)
    }

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            
            gradient
            
            VStack(alignment: .leading) {
                
                Text(landmark.name)
                    .font(.title)
                    .bold()
                
                Text(landmark.park)
            }
            .padding()
            
        }
        .foregroundStyle(.white)
    }
}

#Preview {
    FeatureCard(landmark: ModelData().features[0])
        .aspectRatio(3 / 2, contentMode: .fit)
}
