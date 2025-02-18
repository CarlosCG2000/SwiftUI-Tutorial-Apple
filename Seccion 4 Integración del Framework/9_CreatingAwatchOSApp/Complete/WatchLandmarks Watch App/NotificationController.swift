/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A notification for the watchOS app.
*/

import WatchKit
import SwiftUI
import UserNotifications

// NotificationController maneja la llegada de notificaciones push en un Apple Watch.
class NotificationController: WKUserNotificationHostingController<NotificationView> { // Hereda de WKUserNotificationHostingController<NotificationView>, lo que significa que usa NotificationView como su interfaz de usuario.
    
    var landmark: Landmark?
    var title: String?
    var message: String?

    let landmarkIndexKey = "landmarkIndex"

    override var body: NotificationView {
        NotificationView(title: title,
            message: message,
            landmark: landmark)
    }

    override func didReceive(_ notification: UNNotification) {  // Cuando se recibe una notificación, didReceive(_:) obtiene los datos desde notification.request.content.userInfo.
        
        let modelData = ModelData()

        let notificationData =
            notification.request.content.userInfo as? [String: Any]

        // Extrae el título y el mensaje de la notificación desde la clave aps.alert.
        let aps = notificationData?["aps"] as? [String: Any]
        let alert = aps?["alert"] as? [String: Any]

        title = alert?["title"] as? String
        message = alert?["body"] as? String

        // Obtiene el índice del landmark desde la clave "landmarkIndex" y lo usa para buscar el Landmark en ModelData.
        if let index = notificationData?[landmarkIndexKey] as? Int {
            landmark = modelData.landmarks[index] // La vista NotificationView se actualiza con estos datos.
        }
    }
}
