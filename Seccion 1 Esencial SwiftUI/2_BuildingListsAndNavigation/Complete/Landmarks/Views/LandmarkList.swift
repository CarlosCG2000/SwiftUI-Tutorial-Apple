/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view showing a list of landmarks.
*/

import SwiftUI

struct LandmarkList: View {
    
    // PONER TAMBIEN 'MODO IPAD' PARA VER COMO SE VE AL USAR 'NavigationSplitView'
    
    var body: some View {
        
        NavigationSplitView { // Diferencia de NavigationStack, esta es para dar tambien formato a iPad
            
            List(landmarks) { landmark in
                
                NavigationLink {
                    LandmarkDetail(landmark: landmark) // donde se navega
                } label: {
                    LandmarkRow(landmark: landmark) // lo que se muestra en la fila
                }
                
            }
            .navigationTitle("Landmarks")
            
        } detail: {
            Text("Select a Landmark")
        }
    }
}

#Preview {
    LandmarkList()
}
