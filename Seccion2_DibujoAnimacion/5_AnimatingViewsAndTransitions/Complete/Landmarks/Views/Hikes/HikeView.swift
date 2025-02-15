/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view displaying information about a hike, including an elevation graph.
*/

import SwiftUI

extension AnyTransition {
    
    // Extraida la transición que acaba de agregar como una propiedad estática de , y acceder a la nueva propiedad en el modificador de transición
    static var moveAndFade: AnyTransition {
       //  AnyTransition.move(edge: .trailing)  // Cambiar a usar el move(edge:) transición, para que el gráfico entre y salga del mismo lado.
        
        // Combinar la transición, el modificador para proporcionar diferentes transiciones para cuando la vista aparece y desaparece
        .asymmetric(
            insertion: .move(edge: .trailing).combined(with: .opacity),
            removal: .scale.combined(with: .opacity)
        )
    }
    
}

struct HikeView: View {
    
    var hike: Hike
    
    @State private var showDetail = false

    var body: some View {
        VStack {
            
            HStack {
                
                HikeGraph(hike: hike, path: \.elevation) // Subview for the graph
                    .frame(width: 50, height: 30)

                VStack(alignment: .leading) {
                    Text(hike.name)
                        .font(.headline)
                    Text(hike.distanceText)
                }

                Spacer()

                Button {
                    withAnimation(.easeInOut(duration: 0.8)) { // ANIMACIÓN CON SU DURACIÓN
                        showDetail.toggle()
                    }
                } label: {
                    Label("Graph", systemImage: "chevron.right.circle")
                        .labelStyle(.iconOnly)
                        .imageScale(.large)
                        .rotationEffect(.degrees(showDetail ? 90 : 0))
                        .scaleEffect(showDetail ? 1.5 : 1) // Agregue otro cambio animable haciendo que el botón sea más grande cuando el gráfico esté visible.
                        .padding()
                        //.animation(.easeInOut, value: showDetail)
                        //.animation(.spring(), value: showDetail)
                        //.animation(nil, value: showDetail)
                }
            }

            if showDetail {
                HikeDetail(hike: hike) // Subview for the detail
                     .transition(.moveAndFade) // Animacion de transición (extraida arriba declarada)
                    //.transition(.slide) // Animacion de transición lateral
            }
        }
    }
}

#Preview {
    VStack {
        HikeView(hike: ModelData().hikes[0])
            .padding()
        Spacer()
    }
}
