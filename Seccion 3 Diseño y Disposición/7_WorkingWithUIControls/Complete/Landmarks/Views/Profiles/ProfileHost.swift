/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view that hosts the profile viewer and editor.
*/

import SwiftUI

struct ProfileHost: View {
    
    @Environment(\.editMode) var editMode // OJO:
    
    @Environment(ModelData.self) var modelData // para obtener la instancia de ModelData y los datos del Profile
    
    @State private var draftProfile = Profile.default // llamo a la clase Profile y a la instancia el valor default

    var body: some View {
        
        VStack(alignment: .leading, spacing: 20) {
            
            HStack {
                if editMode?.wrappedValue == .active {
                    Button("Cancel", role: .cancel) {
                        draftProfile = modelData.profile
                        editMode?.animation().wrappedValue = .inactive
                    }
                }
                
                Spacer()
                
                EditButton() // ¿ES UN TIPO DE BOTÓN?
            }

            if editMode?.wrappedValue == .inactive {
                
                ProfileSummary(profile: modelData.profile)
                
            } else {
                
                ProfileEditor(profile: $draftProfile)
                
                    .onAppear {
                        draftProfile = modelData.profile
                    }
                    .onDisappear {
                        modelData.profile = draftProfile
                    }
            }
            
        }
        .padding()
    }
}

#Preview {
    ProfileHost()
        .environment(ModelData())
}
