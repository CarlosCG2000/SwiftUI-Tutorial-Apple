/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
Storage for model data.
*/

import Foundation

// Cree una variedad de puntos de referencia donde llama al la función pasando por parametro desde los que inicializa .landmarkData.json
var landmarks: [Landmark] = load(filename: "landmarkData")

// Crear un load(_:) método que obtiene datos JSON con un nombre dado del paquete principal de las aplicaciones.

// T: Decodable: Un tipo genérico que se puede decodificar desde datos JSON.
func load<T: Decodable>(filename: String) -> T {
    
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: "json") // 1. Obtiene la ruta 'url' del archivo JSON
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file) // 2. Obtiene los datos (data) del archivo JSON desde la ruta 'url'
        
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder() // Se declara el objeto para decodificar los datos JSON en un modelo
        
        print("✅ Parse \(filename) as \(T.self)")
        
        return try decoder.decode(T.self, from: data) // 3. Decodifica los datos JSON en un modelo, pasando por parametro el tipo de modelo (generico) y los datos JSON (data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
    
}
