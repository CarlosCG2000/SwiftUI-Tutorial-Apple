/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view that summarizes a profile.
*/

import SwiftUI

struct ProfileSummary: View {
    
    @Environment(ModelData.self) var modelData // para obtener le hikes
    
    var profile: Profile

    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                
                // Seccion datos del usuario
                Text(profile.username)
                    .bold()
                    .font(.title)

                Text("Notifications: \(profile.prefersNotifications ? "On": "Off" )")
                Text("Seasonal Photos: \(profile.seasonalPhoto.rawValue)")
                Text("Goal Date: ") + Text(profile.goalDate, style: .date)

                Divider()

                // Seccion de Badges
                VStack(alignment: .leading) {
                    Text("Completed Badges")
                        .font(.headline)

                    ScrollView(.horizontal) {
                        HStack {
                            HikeBadge(name: "First Hike")
                            
                            HikeBadge(name: "Earth Day")
                                .hueRotation(Angle(degrees: 90)) // gira el color del badge
                            
                            HikeBadge(name: "Tenth Hike")
                                .grayscale(0.5)
                                .hueRotation(Angle(degrees: 45)) // gira el color del badge
                        }
                        .padding(.bottom)
                    }
                }

                Divider()

                // Seccion de Hikes
                VStack(alignment: .leading) {
                    
                    Text("Recent Hikes")
                        .font(.headline)

                    HikeView(hike: modelData.hikes[0])
                }
            }
            .padding()
        }
    }
}

#Preview {
    ProfileSummary(profile: Profile.default)
        .environment(ModelData())
}
