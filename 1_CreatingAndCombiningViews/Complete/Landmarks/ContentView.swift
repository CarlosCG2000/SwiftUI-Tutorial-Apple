/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view showing the details for a landmark.
*/

import SwiftUI

// Los archivos de vista SwiftUI declaran una estructura y una vista previa.
struct ContentView: View { // La estructura se ajusta a la View protocolo y describe el contenido y el diseño de las vistas.
    
    /// `@ViewBuilder` del protocolo `View`: permite que `body` devuelva múltiples vistas sin necesidad de usar `Group {}`.
    
    var body: some View { // La declaración de vista previa crea una vista previa para esa vista.
        
        VStack {
            
            MapView()
                .frame(height: 300)

            CircleImage()
                .offset(y: -130)
                .padding(.bottom, -130)

            VStack(alignment: .leading) {
                
                Text("Turtle Rock")
                    .font(.title)
                    .multilineTextAlignment(.center)
                
                HStack {
                    Text("Joshua Tree National Park")
                    
                    Spacer()
                    
                    Text("California")
                        .accessibilityLabel(/*@START_MENU_TOKEN@*/"Label"/*@END_MENU_TOKEN@*/)
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)

                Divider() // la linea de separación tipo una barra horizontal (hr).

                Text("About Turtle Rock")
                    .font(.title2)
                
                Text("Descriptive text goes here.")
                
            }
            .padding()

            Spacer()
        }
    }
}

#Preview {
    ContentView()
}
