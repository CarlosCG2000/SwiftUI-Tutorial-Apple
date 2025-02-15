/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view showing a scrollable list of landmarks.
*/

import SwiftUI

struct CategoryRow: View {
    
    var categoryName: String
    
    var items: [Landmark]

    var body: some View {
        
        VStack(alignment: .leading) {
            
            // Titulo de la categoria
            Text(categoryName)
                .font(.headline)
                .padding(.leading, 15)
                .padding(.top, 5)

            // Listado horizontal de las landmarks
            ScrollView(.horizontal, showsIndicators: false) { // showsIndicators: false, elimina la barra de desplazamiento
                
                HStack(alignment: .top, spacing: 0) {
                    ForEach(items) { landmark in
                        NavigationLink {
                            LandmarkDetail(landmark: landmark)
                        } label: {
                            CategoryItem(landmark: landmark)
                        }
                    }
                }
            }
            .frame(height: 185)
        }
    }
}

#Preview {
    let landmarks = ModelData().landmarks
    return CategoryRow (
        categoryName: landmarks[0].category.rawValue,
        items: Array(landmarks.prefix(4))
    )
}
