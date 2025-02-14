/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A single row to be displayed in a list of landmarks.
*/

import SwiftUI

struct LandmarkRow: View {
    
    var landmark: Landmark

    var body: some View {
        
        HStack {
            
            landmark.image
                .resizable()
                .frame(width: 50, height: 50)
            
            Text(landmark.name)

            Spacer()
        }
    }
}
// Se pueden añadir varios preview y darles un nombre (se eligen en la parte superior del dispositivo)
#Preview("Un elemento") {
        LandmarkRow(landmark: landmarks[0])
}

#Preview("Varios elementos") {
  
    Group {
        LandmarkRow(landmark: landmarks[0])
        LandmarkRow(landmark: landmarks[1])
        LandmarkRow(landmark: landmarks[2])
    }
    
}
