/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The top-level definition of the Landmarks app.
*/

import SwiftUI

@main // El @main el atributo identifica el punto de entrada de las aplicaciones.
struct LandmarksApp: App { // Una aplicación que utiliza el ciclo de vida de la aplicación SwiftUI tiene una estructura que se ajusta a la App protocolo.
    
    /// `@SceneBuilder` del protocolo `App`: Permite que body devuelva múltiples escenas sin necesidad de agruparlas manualmente.
   
    var body: some Scene { // Los estructurados body la propiedad devuelve una o más escenas, que a su vez proporcionan contenido para su visualización.
        WindowGroup {
            ContentView()
        }
    }
    
}
