/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view wrapping a UIPageControl.
*/

import SwiftUI
import UIKit

/**
 Esta clase envuelve UIPageControl de UIKit dentro de SwiftUI usando UIViewRepresentable.
 Se usa para mostrar un indicador de paginación en una vista que tiene varias páginas.
 
 🔹 UIViewRepresentable permite usar UIView en SwiftUI.
 🔹 Es útil para componentes como UIPageControl, UISlider, MKMapView, etc.
 🔹 Se necesita un Coordinator para manejar eventos UIKit.
 🔹 Este código crea un UIPageControl totalmente funcional en SwiftUI.
 
 0️⃣    numberOfPages almacena el número total de páginas.
 1️⃣    @Binding var currentPage permite que SwiftUI controle la página actual.
 2️⃣    makeCoordinator() crea un coordinador que manejará eventos de UIKit.
 3️⃣    makeUIView(context:) crea y devuelve un UIPageControl.
 4️⃣    addTarget hace que updateCurrentPage(sender:) se llame cuando el usuario cambia la página.
 5️⃣    updateUIView(_:context:) actualiza la vista si currentPage cambia en SwiftUI.
 6️⃣    Coordinator es un puente entre UIKit y SwiftUI.
 7️⃣    updateCurrentPage(sender:) actualiza currentPage en SwiftUI cuando el usuario toca UIPageControl.
 */
struct PageControl: UIViewRepresentable { // permite usar vistas de UIKit (UIView) dentro de SwiftUI.
    
    var numberOfPages: Int // 0️⃣ Número total de páginas
    
    @Binding var currentPage: Int // 1️⃣ Página actual (estado compartido con SwiftUI)

    func makeCoordinator() -> Coordinator { // 2️⃣ Crea el coordinador para manejar eventos de UIKit
        Coordinator(self)
    }

    func makeUIView(context: Context) -> UIPageControl { // 3️⃣ Crea el UIPageControl
        let control = UIPageControl()
        
        control.numberOfPages = numberOfPages
        
        // 4️⃣ Añadir un target para detectar cambios en el control de página
        control.addTarget(
            context.coordinator,
            action: #selector(Coordinator.updateCurrentPage(sender:)),
            for: .valueChanged)

        return control
    }

    func updateUIView(_ uiView: UIPageControl, context: Context) { // 5️⃣ Actualiza la vista cuando cambia el estado
        uiView.currentPage = currentPage
    }

    // 6️⃣ Coordinador que maneja eventos de UIPageControl
    /**
     📌 ¿Por qué usamos un Coordinator?
         •    UIPageControl usa eventos (addTarget) en UIKit.
         •    SwiftUI no tiene un mecanismo de eventos como UIControlEvent.
         •    El Coordinator actúa como un puente para recibir eventos y actualizar @Binding.

     🔹 Ejemplo sin Coordinator: No podríamos actualizar currentPage en SwiftUI.
     🔹 Ejemplo con Coordinator: SwiftUI recibe el evento y cambia la página correctamente.
     */
    
    class Coordinator: NSObject {
        var control: PageControl

        init(_ control: PageControl) {
            self.control = control
        }

        @objc
        func updateCurrentPage(sender: UIPageControl) { // 7️⃣ Método que actualiza la página actual en SwiftUI
            control.currentPage = sender.currentPage
        }
    }
}
