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
                        draftProfile = modelData.profile // Restablece los cambios (draftProfile = modelData.profile).
                        editMode?.animation().wrappedValue = .inactive // Desactiva el modo de edición (editMode?.wrappedValue = .inactive). `editMode` es un Optional (`EditMode?`), por eso se usa `?.wrappedValue.`
                    }
                }
                
                Spacer()
                
                EditButton() // Es el boton `Edit un botón predeterminado de SwiftUI que alterna automáticamente entre .active e .inactive.
            }

            if editMode?.wrappedValue == .inactive {
                
                ProfileSummary(profile: modelData.profile)
                
            } else {
                
                ProfileEditor(profile: $draftProfile)
                
                    .onAppear {
                        draftProfile = modelData.profile // el nuevo valor de `draftProfile` es igual a `modelData.profile`.
                    }
                    .onDisappear {
                        modelData.profile = draftProfile // el nuevo valor de `modelData.profile` es igual a `draftProfile`.
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
