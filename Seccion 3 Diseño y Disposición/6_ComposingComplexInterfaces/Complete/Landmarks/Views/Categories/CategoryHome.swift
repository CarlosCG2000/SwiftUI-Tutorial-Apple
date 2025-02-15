/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view showing featured landmarks above a list of landmarks grouped by category.
*/

import SwiftUI

struct CategoryHome: View {
    
    @Environment(ModelData.self) var modelData

    var body: some View {
        
        NavigationSplitView {
            
            List {
            
                // Imagen de la primera Landmark que tiene su feature a true (es detacado)
                modelData.features[0].image // image feature, de momento solo la primera ya en otro proyecto se modificara esto
                    .resizable()
                    .scaledToFill()
                    .frame(height: 200)
                    .clipped()
                    .listRowInsets(EdgeInsets())

                // Listado de categorias con sus landmarks
                ForEach(modelData.categories.keys.sorted(), id: \.self) { key in
                    CategoryRow(categoryName: key, items: modelData.categories[key]!)
                }
                .listRowInsets(EdgeInsets()) // Elimina el padding predeterminado de los elementos de la lista.
            }
            .navigationTitle("Featured")
            
        } detail: {
            Text("Select a Landmark")
        }
    }
}

#Preview {
    CategoryHome()
        .environment(ModelData())
}
