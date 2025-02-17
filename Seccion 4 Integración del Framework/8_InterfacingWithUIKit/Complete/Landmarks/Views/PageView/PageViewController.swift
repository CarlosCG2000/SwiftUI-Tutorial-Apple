/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view that wraps a UIPageViewController.
*/

import SwiftUI
import UIKit

/**
Este código crea un PageViewController que permite a los usuarios deslizarse entre varias vistas SwiftUI como si fueran páginas en un carrusel.
✅ Utiliza UIPageViewController (de UIKit) dentro de SwiftUI.
✅ Soporta deslizamiento horizontal entre páginas.
✅ Usa un coordinador (Coordinator) para manejar la navegación entre páginas.
✅ Actualiza la página actual en @Binding var currentPage.
 
 1️⃣ Propiedades:  Se definen pages (array de vistas) y currentPage (página actual).
 2️⃣ makeUIViewController:  Crea el UIPageViewController y lo asocia al coordinador.
 3️⃣ updateUIViewController:  Cambia la página cuando currentPage se actualiza.
 4️⃣ Coordinator:  Gestiona la lógica de navegación.
 5️⃣ Métodos de navegación:   Permiten deslizar entre páginas (previa/siguiente).
 6️⃣ didFinishAnimating:   Actualiza currentPage cuando el usuario desliza.
*/

// El controlador de vista de página almacena una matriz de Page instancias, que deben ser un tipo de View. Estas son las páginas que utiliza para desplazarse entre puntos de referencia.
struct PageViewController<Page: View>: UIViewControllerRepresentable {
    
    // X_🔹 Propiedades principales
    var pages: [Page] // 0_Es un array que contiene todas las páginas que se mostrarán en el carrusel. Almacena las vistas que se mostrarán en el carrusel.
    @Binding var currentPage: Int // Controla qué página se está mostrando.  Permite a SwiftUI conocer y actualizar la página actual.

    // 4_🔹 makeCoordinator(): Crea un coordinador.
    // El coordinador (Coordinator) maneja la lógica de navegación. SwiftUI llama a este método antes de configurar el controlador.
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    //1_🔹 makeUIViewController(context:): Crea UIPageViewController
    // SwiftUI llama a este método una sola vez cuando está listo para mostrar la vista y luego administra el ciclo de vida de los controladores de vista.
    // Crea el UIPageViewController que permite deslizar entre páginas. Define que el context.coordinator será el delegado y el proveedor de datos.
    func makeUIViewController(context: Context) -> UIPageViewController {
        
        let pageViewController = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal)
        
        pageViewController.dataSource = context.coordinator
        pageViewController.delegate = context.coordinator

        return pageViewController
    }

    // 2_🔹 updateUIViewController(_:context:): Actualiza la vista
    // Por ahora, creas el eso alberga el Vista SwiftUI en cada actualización. Más tarde, hará que esto sea más eficiente inicializando el controlador solo una vez durante la vida útil del controlador de vista de página
    // Se llama cada vez que currentPage cambia. Muestra la vista correspondiente en controllers[currentPage].
    func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
        pageViewController.setViewControllers(
            [context.coordinator.controllers[currentPage]], direction: .forward, animated: true)
    }

    // 3_🎛 Implementación del Coordinador
    // La clase Coordinator maneja la navegación entre páginas.
    // Una vista SwiftUI que representa un controlador de vista UIKit puede definir un Coordinator escriba que SwiftUI administre y proporcione como parte del contexto de vistas representables. SwiftUI gestiona tu coordinador de tipos y lo proporciona como parte del contexto al llamar a los métodos que creó anteriormente
    class Coordinator: NSObject, // Extiende NSObject para interactuar con UIKit.
                    // Estos dos métodos establecen las relaciones entre los controladores de vista, para que pueda deslizar hacia adelante y hacia atrás entre ellos y  manejar la navegación.
                       UIPageViewControllerDataSource,
                       UIPageViewControllerDelegate {
    
        // 🔹 Propiedades del Coordinator.
        var parent: PageViewController // Referencia a PageViewController para acceder a sus datos.
        var controllers = [UIViewController]() // Contiene los controladores de vista (UIHostingController) que representan las páginas SwiftUI.

        // 🔹 init(_ pageViewController:): Configura los controladores
        // Convierte cada vista SwiftUI en UIHostingController y la almacena en controllers.
        // El coordinador es un buen lugar para almacenar estos controladores, porque el sistema los inicializa solo una vez, y antes de que los necesite para actualizar el controlador de vista.
        init(_ pageViewController: PageViewController) {
            parent = pageViewController
            controllers = parent.pages.map { UIHostingController(rootView: $0) }
        }

        // 🔹 Navegación entre páginas
        // 📍 viewControllerBefore: Devuelve la página anterior o vuelve a la última si estamos en la primera.
        func pageViewController(
            _ pageViewController: UIPageViewController,
            viewControllerBefore viewController: UIViewController) -> UIViewController? {
                
            guard let index = controllers.firstIndex(of: viewController) else {
                return nil
            }
                
            if index == 0 {
                return controllers.last // Vuelve al final si está en la primera página
            }
                
            return controllers[index - 1] // Va a la página anterior
        }

        // 📍 viewControllerAfter: Devuelve la página siguiente o vuelve a la primera si estamos en la última.
        func pageViewController(
            _ pageViewController: UIPageViewController,
            viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let index = controllers.firstIndex(of: viewController) else {
                return nil
            }
            if index + 1 == controllers.count {
                return controllers.first // Vuelve al inicio si está en la última
            }
                
            return controllers[index + 1] // Va a la página siguiente
        }

        // 🔹 Actualizar currentPage después de deslizar: Cuando el usuario termina de deslizar, actualiza currentPage en SwiftUI.
        func pageViewController(
            _ pageViewController: UIPageViewController,
            didFinishAnimating finished: Bool,
            previousViewControllers: [UIViewController],
            transitionCompleted completed: Bool) {
            
            if completed,
               let visibleViewController = pageViewController.viewControllers?.first,
               let index = controllers.firstIndex(of: visibleViewController) {
                parent.currentPage = index // Actualiza `currentPage`
            }
        }
    }
}
