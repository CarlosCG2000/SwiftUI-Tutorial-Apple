/*
 See the LICENSE.txt file for this sample’s licensing information.
 
 Abstract:
 A view that clips an image to a circle and adds a stroke and shadow.
 */

import SwiftUI

struct CircleImage: View {
    
    var body: some View {
        
        Image("turtlerock") // iamgen añadida en `Assets`
            .clipShape(Circle()) // la forma de recorte circular a la imagen
            .overlay { // Cree otro círculo con un trazo gris y luego agréguelo como una superposición para darle a la imagen un borde.
                Circle().stroke(.white, lineWidth: 5)
            }
            .shadow(radius: 7) // agregue una sombra con un radio de 7 puntos.
    }
}

#Preview {
    CircleImage()
}
