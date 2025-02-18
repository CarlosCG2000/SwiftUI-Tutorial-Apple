/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The root view for the app on Apple Watch.
*/

import SwiftUI
import UserNotifications

struct ContentView: View {
    var body: some View {
        
        LandmarkList() // vista
            .task { // se solicita permiso para notificaciones usando UNUserNotificationCenter.
                let center = UNUserNotificationCenter.current() // pide permiso para mostrar: alertas, sonidos, badges en el ícono de la app.
                _ = try? await center.requestAuthorization( // try? await sugiere que la autorización podría fallar, pero no detendrá la ejecución.
                    options: [.alert, .sound, .badge]
                )
            }
    }
}

#Preview {
    ContentView()
        .environment(ModelData())
}
