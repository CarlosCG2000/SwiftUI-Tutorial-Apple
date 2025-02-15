/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view showing a single category item.
*/

import SwiftUI

struct CategoryItem: View {
    
    var landmark: Landmark

    var body: some View {
        
        VStack(alignment: .leading) {
            
            landmark.image
                .renderingMode(.original) // se utiliza para mostrar una imagen con sus colores originales, en lugar de aplicarle el tinte (tint) predeterminado de la vista que la contiene.
                .resizable()
                .frame(width: 155, height: 155)
                .cornerRadius(5)
            
            Text(landmark.name)
                .foregroundStyle(.primary)
                .font(.caption)
        }
        .padding(.leading, 15)
        
    }
}

#Preview {
    CategoryItem(landmark: ModelData().landmarks[0])
}
