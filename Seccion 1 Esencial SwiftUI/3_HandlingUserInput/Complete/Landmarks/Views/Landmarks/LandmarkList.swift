/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view showing a list of landmarks.
*/

import SwiftUI

struct LandmarkList: View {
    
    @Environment(ModelData.self) var modelData // permite que la vista `LandmarkList` acceda a datos globales sin pasarlos como parámetros. Ya que son tambien necesarios en la vista `LandmarkDetail`, y se inyectan en el entorno de la vista `ContentView`.
    //@State var modelData: ModelData = ModelData() // no se puede porque se crea una nueva instancia en cada vista lo que hace que por muchho que modificarlamos una isntancia en LandmarkDetail no se veria reflejado en LandmarkList.
    
    @State private var showFavoritesOnly = false // Es un estado porque puede cambiar en tiempo de ejecución

    // Filtrar los landmarks para mostrar solo los favoritos
    var filteredLandmarks: [Landmark] {
        modelData.landmarks.filter { landmark in
            (!showFavoritesOnly || landmark.isFavorite) // Si no se quiere ver solo favoritos o si es favorito
        }
    }

    var body: some View {
        NavigationSplitView {
            List {
                // Toggle para mostrar solo favoritos
                Toggle(isOn: $showFavoritesOnly) { //$ para que sea un binding (para acceder a un enlace a una variable de estado, o una de sus propiedades.)
                    Text("Favorites only")
                }

                // Usamos al version filtrada de los landmarks
                ForEach(filteredLandmarks) { landmark in
                    NavigationLink {
                        LandmarkDetail(landmark: landmark)
                    } label: {
                        LandmarkRow(landmark: landmark)
                    }
                }
            }
            .animation(.default, value: filteredLandmarks) // Para que la animación sea mas suave
            .navigationTitle("Landmarks")
        } detail: {
            Text("Select a Landmark")
        }
    }
}

#Preview {
    LandmarkList()
        .environment(ModelData()) // Esto se usa en el #Preview o en el ContentView(), y sirve para inyectar una instancia de ModelData en el entorno de SwiftUI. Es necesario para que @Environment(ModelData.self) pueda encontrar una instancia válida de ModelData.
}
