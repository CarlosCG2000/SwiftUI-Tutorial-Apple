/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A representation of user profile data.
*/

import Foundation

struct Profile {
    
    var username: String
    var prefersNotifications = true
    var seasonalPhoto = Season.winter
    var goalDate = Date()

    static let `default` = Profile(username: "g_kumar") //Instancia de ejemplo por defecto: , prefersNotifications: true, seasonalPhoto: .winter, goalDate: Date())

    enum Season: String, CaseIterable, Identifiable {
        case spring = "🌷"
        case summer = "🌞"
        case autumn = "🍂"
        case winter = "☃️"

        var id: String { rawValue }
    }
}
