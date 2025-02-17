/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view showing the details for a landmark.
*/

import SwiftUI

struct LandmarkDetail: View {
    
    @Environment(ModelData.self) var modelData // se compartira en toda la app ya que se encuentra en en LankmarkList y se pasa a LandmarkDetail  (en mi app se llama a el entorno de Enviroment de la Swift Data)
    // @State var modelData: ModelData = ModelData() // no se puede porque se crea una nueva instancia en cada vista lo que hace que por muchho que modificarlamos una instancia en LandmarkDetail no se veria reflejado en LandmarkList.
    
    var landmark: Landmark

    var landmarkIndex: Int {
        modelData.landmarks.firstIndex(where: { $0.id == landmark.id })!
    }

    var body: some View {
        
        @Bindable var modelData = modelData // Igual que @Binding, pero para entornos de datos observables (clases, estructuras, etc.) en vez de para propiedades de estado.
        
        ScrollView {
            MapView(coordinate: landmark.locationCoordinate)
                .frame(height: 300)

            CircleImage(image: landmark.image)
                .offset(y: -130)
                .padding(.bottom, -130)

            VStack(alignment: .leading) {
                HStack {
                    Text(landmark.name)
                        .font(.title)
                    FavoriteButton(isSet: $modelData.landmarks[landmarkIndex].isFavorite)
                }

                HStack {
                    Text(landmark.park)
                    Spacer()
                    Text(landmark.state)
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)

                Divider()

                Text("About \(landmark.name)")
                    .font(.title2)
                Text(landmark.description)
            }
            .padding()
        }
        .navigationTitle(landmark.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let modelData = ModelData()
    return LandmarkDetail(landmark: modelData.landmarks[0])
        .environment(modelData)
}
