/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
Storage for model data.
*/

import Foundation

@Observable
class ModelData {
    
    var landmarks: [Landmark] = load("landmarkData.json")
    var hikes: [Hike] = load("hikeData.json")

    // Propiedad computada que devuelve un array de Landmark que tienen la propiedad isFeatured en true.
    var features: [Landmark] {
        landmarks.filter { $0.isFeatured }
    }

    // Un diccionario que agrupa los landmarks por categoría.
    var categories: [String: [Landmark]] {
        Dictionary(
            grouping: landmarks, // The array of landmarks.
            by: { $0.category.rawValue } // The category of each landmark.
        )
    }
}

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
