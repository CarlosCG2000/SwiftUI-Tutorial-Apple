/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A representation of a single landmark.
*/

import Foundation
import SwiftUI
import CoreLocation

// Protocolo Codable la conformidad facilita el movimiento de datos entre la estructura y un archivo de datos. Confiarás en el Decodable componente de la Codable protocolo más adelante en esta sección para leer datos del archivo.
//Protocolo Identifiable solo necesita agregar una propiedad 'var id' para decodificarla al leer los datos. Hace que al hacer la lista yo no necesites añadir una identificación ya que es la propia estructura la que se encarga de ello (ya no hace falta por ejemplo poner en una lista dinámica: ',\.id').
struct Landmark: Codable, Identifiable, Hashable {
    
    var id: Int
    var name: String
    var park: String
    var state: String
    var description: String
    // variable privada que almacena el nombre de la imagen
    private var imageName: String
    // variable privada que almacena las coordenadas de la ubicación.
    private var coordinates: Coordinates
    
    // Estructura que almacena las coordenadas de la ubicación.
    struct Coordinates: Hashable, Codable {
        var latitude: Double
        var longitude: Double
    }
    
    // Propiedad calculada que carga una imagen con el nombre almacenado en imageName.
    var image: Image {
        Image(imageName)
    }

    // Propiedad calculada que devuelve una ubicación de coordenadas.
    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude)
    }
}
