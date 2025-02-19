# CURSO: `https://developer.apple.com/tutorials/swiftui/`

# ___________________________ SECCIÓN 1 `ESENCIALES DE SWIFT UI` ___________________________

# ..................... PROYECTO:`1_CreatingAndCombiningViews` .....................
Crea a través de una pantalla la vista con detalles de un lugar con texto, imagen y mapa.

## 1. `Protocolos`: App, Scene, View
1. App:
`@MainActor`: Garantiza que el código que usa este protocolo se ejecute en el hilo principal.
`associatedtype Body : Scene`: Indica que cada tipo que conforme App debe definir un tipo Body, que será una Scene.
`@SceneBuilder @MainActor @preconcurrency var body: Self.Body { get }`: `@SceneBuilder`: Permite que body devuelva múltiples escenas sin necesidad de agruparlas manualmente.
`@MainActor @preconcurrency init()`: Define un inicializador vacío que Swift genera automáticamente, por lo que no necesitas escribirlo manualmente.

2. Scene:
`@SceneBuilder @MainActor @preconcurrency var body: Self.Body { get }`: Esta línea define el requisito obligatorio que debe cumplir cualquier tipo (struct) que conforme el protocolo App. Vamos a analizarlo parte por parte.
`@SceneBuilder`: es un Property Wrapper de SwiftUI.
Facilita la escritura de código declarativo, permitiendo que body devuelva una o varias Scene sin necesidad de envolverlas en estructuras condicionales o arrays.
`@preconcurrency`: Se introdujo para garantizar compatibilidad con código previo a Swift Concurrency (async/await). Indica que no se aplican automáticamente ciertas verificaciones de concurrencia en entornos antiguos.
`var body: Self.Body { get }`: body es una propiedad computada obligatoria que debe devolver una Scene.
Self.Body significa que cada tipo que implemente App debe definir su propia Body, que siempre debe ser un Scene.

3. View:
`@MainActor`: Garantiza que el código que usa este protocolo se ejecute en el hilo principal.
`@preconcurrency`: Esto es un modificador de compatibilidad que ayuda a que View funcione correctamente con Swift Concurrency (async/await).
`associatedtype Body : View`: Define que cada tipo que conforme el protocolo View debe tener un tipo Body que también sea una View.
`@ViewBuilder @MainActor @preconcurrency var body: Self.Body { get }`: `@ViewBuilder`: Permite que body devuelva múltiples vistas sin necesidad de usar Group {}.

## 2. ¿Qué es un `Property Wrapper` en Swift?
Un Property Wrapper en Swift es una estructura que encapsula la lógica de acceso a una propiedad, permitiendo modificar cómo se almacena o se accede a su valor.

Se usan para agregar funcionalidades sin repetir código, como:
• Validaciones automáticas
• Transformaciones de valores
• Persistencia de datos
• Optimización de rendimiento

## 3. `Personalizar elemento` de vista (tanto `Preview()` como `código`)
- En `Preview()` me pongo en el botón tipo `flecha` y sobre el elemento que quiera tecleo: `Command-Control-click` y eligo `Show SwiftUI Inspector...` con el cual puedo ahora modificar el elemento al estilo `UIKit` un poco pero en `SwiftUI`

- Tambien se puede llamar desde el `código` cogiendo el texto que queramos con `click derecho` y eligo `Show SwiftUI Inspector...` y obtengo la misma pop up para modificar.

## 4. Añadir y ver `elementos disponibles`
Abra la biblioteca haciendo clic en el `botón más (+)` en la parte superior derecha de la ventana de Xcode y saldran todos los elementos disponibles de Xcode:
- En al sección `Views` estar la subsección `Control` con ejemplos nuevos para mi como `ColorPicker`, `DisclosureGroup` (desplegable), `Form`, `Gauge` (barra de cargando), `Link` (sirve tambien para navegar), etc. Pero hay otras subsecciones como `Layout`, `Others`.
- Otra sección es `Modifiers` con subsecciones como `controles`, `efectos`, `layout`, `text`, `image`...
- Y otras secciones son tambien `Snippes`, `Media`, `Color` y `Symbol`.

## 5. `Mapa` en Preview()
En un mapa al pulsar `opt` actua como si estuvieras poniendo dos dedos para expandir o minimizar el mapa.

# ..................... PROYECTO:`2_BuildingListsAndNavigation` .....................
Añada un listado a través de un swifton con varios lugares (ya no solo hay uno) a los que poder acceder navegando por la lista y navegar a cada lugar con más detalles (la vista de detalles del lugar que se creo en el anterior proyecto).

## 1. Visualizar varios `Previews` en un mismo fichero
Se pueden definir varios `Previews` y darles un nombre para identificarlos como `#Preview("Un elemento") { ... }` y en el dispositivo en la parte superior salen las opciones de las `Previews` para elegir cual  queremos ver.

## 2. Lista `estática` pasar a lista `dinámica`
Esto es una lista estática:
```swift
        List {
            ForEach(episodes) { episodeItem in
            ...
            }
        }
```

Esto es una lista dinámica (más óptimo que la estática):
```swift
        // si `episodes` es Identifiable no hace falta poner el `\.id`
        List(episodes, \.id) { episodeItem in
            ...
        }
```

## 3. `NavigationSplitView` alternativa a `NavigationStack`
`NavigationSplitView` en `Ipad` contiene una barra lateral como la lista de elementos y un panel de contenido dinámico y en el `Iphone` se solo un listado normal como si fuera un `NavigationStack`.

`NavigationSplitView` es una estructura en SwiftUI que proporciona un layout adaptable de múltiples columnas en dispositivos como `iPad y Mac`. Permite dividir la interfaz en una `lista` (`sidebar`) y un `contenido detallado` (`detail view`).

- ¿Qué contiene?
+ `Lista principal` (`sidebar`): Se define en el primer bloque {}. Aquí puedes colocar una lista con opciones.
+ `Vista de detalle` (`detail view`): Se muestra en el segundo bloque {}. Aquí se despliega el contenido según la selección del usuario.

| `NavigationStack` | `NavigationSplitView` |
|------------------|--------------------|
| Diseño basado en **una sola columna** | Diseño de **dos o más columnas** |
| Ideal para iPhone 📱 | Ideal para iPad y Mac 💻 |
| Se usa para flujos secuenciales (push/pop) 🔄 | Se usa para dividir sidebar y contenido 🪟 |
| Reemplazo moderno de `NavigationView` en iOS 16+ | Reemplazo moderno de `UISplitViewController` en iOS 16+ |

📌 **`NavigationSplitView` es ideal para aplicaciones de `iPad y Mac` con una barra lateral y `un panel de contenido dinámico`.** 🚀

## 4. Uso de.constant()
Es un `Binding` fijo que nunca cambia su valor. Se usa cuando un View requiere un Binding<T>, pero no quieres o no necesitas que el usuario lo modifique.

🔹 ¿Por qué usar `.constant()`?
1️⃣ Evitas definir una variable `@State` si no `necesitas modificarla`.
2️⃣ Es útil en vistas de solo lectura o demostraciones.
3️⃣ Previene cambios no deseados, ya que el valor es fijo.

🔹 Ejemplo con y sin .constant()
```swift
    @State private var position: MapCameraPosition = .region(region)

    Map(position: $position) // El usuario puede cambiar la posición
```

🚫 Con .constant() (fijo, sin cambios)
```swift
    Map(position: .constant(.region(region))) // No permite cambios
```

🔹 ¿Cuándo usar cada uno?
• Usa .`constant()` si no quieres que la posición del mapa cambie.
• Usa `@State` y `$binding` si quieres que el usuario pueda interactuar con el mapa.

Si quieres que el usuario mueva el mapa y recuerde la posición, usa @State. Si solo quieres mostrar una ubicación fija, usa .constant(). 🚀

# ..................... PROYECTO:`3_HandlingUserInput` .....................
Añadir poder seleccionar lugares favoritos (se ha añadido el campo tambien en el swifton) y que se muestre tanto en los detalles del lugar como en el listado pudiendo filtrar para ver solo el listado con los favoritos.

## 1. ¿Por qué `@State` debe ser `private`?
📌 1️⃣ `@State` es `específico de una vista`
`@State` se usa para datos internos de una `vista` y sus `subvistas`. SwiftUI gestiona su `ciclo de vida`, por lo que si lo expusieras públicamente, otras vistas podrían modificarlo de forma `no controlada`, lo que rompería `la reactividad del sistema`.

📌 2️⃣ Se `evita` que otras vistas lo `modifiquen directamente`
Si `@State` fuera público, podrías modificarlo desde fuera de la vista, lo que haría que la actualización del estado fuera `menos predecible`.

📌 3️⃣ Se usa `Binding` cuando otra vista necesita acceder al estado
Si una vista hija necesita modificar un `@State`, en lugar de hacerlo público, pasas un `Binding` para que solo acceda a la `referencia controlada`.

✅ Estado privado con `@State`
```swift
struct ParentView: View {
    @State private var showFavoritesOnly = false

    var body: some View {
        ChildView(isFavorite: $showFavoritesOnly) // Pasamos un Binding
    }
}
```

🚀 Vista secundaria con `Binding`
```swift
struct ChildView: View {
    @Binding var isFavorite: Bool // Binding permite modificar el estado de la vista padre

    var body: some View {
        Toggle("Show Favorites Only", isOn: $isFavorite)
    }
}
```

Aquí, `ChildView` no necesita acceso directo a `@State`, solo a su `Binding`, lo que mantiene `showFavoritesOnly` encapsulado en `ParentView`.

🔹 ¿Cuándo `@State` no necesita ser `private`?
En algunos casos, puedes no marcarlo como private, por ejemplo, si necesitas que otras vistas accedan a él directamente (aunque `no es lo recomendable` en la mayoría de los casos).

📌 `Mejor práctica` → Usar `private` y `Binding` cuando sea necesario. 🚀

## 2. `Animación` en lista
Mejora la `animación de filtrado` agregando un `animation(_:)` modificador que comienza cuando el cambios de valor de listado.

```swift
        List (filteredLandmarks) { landmark in
            NavigationLink {
                LandmarkDetail(landmark: landmark)
            } label: {
                LandmarkRow(landmark: landmark)
            }
        }
        .animation(.default, value: filteredLandmarks)
```

## 3. ¿Qué es un `macro` en `Swift`?
En Swift, un `macro` es una forma de `generar código automáticamente` en `tiempo de compilación`. Se introdujeron en `Swift 5.9` y permiten `transformar código fuente` antes de que se `compile`, lo que ayuda a `reducir la repetición` y mejorar la seguridad del código.

🔹 📌 `¿Cómo funcionan?`
Los macros `analizan el código fuente` y lo reemplazan por otro código generado automáticamente. Se parecen a las funciones, pero en lugar de ejecutarse en tiempo de ejecución, se expanden en `tiempo de compilación`.

🔹 `Tipos de Macros` en Swift
📌 1. Expansión de `Expresiones` (`#myMacro`)
Se usa en expresiones y se reemplaza por otra expresión en tiempo de compilación.
```swift
let number = #double(21)  // Se expande a: let number = 42
```

📌 2. Expansión de `Declaraciones` (`@MyMacro`)
Se usa en `declaraciones` como funciones, structs o clases.

```swift
@Observable // Genera automáticamente código para hacer seguimiento de cambios en una clase
class User {
    var name: String
}
```

📌 3. Expansión de `Membros` (`#MemberMacro`)
Añade propiedades o métodos automáticamente a una estructura o clase.
```swift
struct Persona {
    #addLogging
}
```

Esto podría generar automáticamente métodos como:
```swift
struct Persona {
    func log() { print("Logging Persona...") }
}
```

🔹 ¿`Cómo se usan` los Macros en SwiftUI?
SwiftUI aún no usa macros de `forma directa`, pero con macros personalizadas se pueden `generar automáticamente` propiedades o vistas. Un ejemplo es `@Observable`, que ayuda a generar código para la reactividad

🔹 Conclusión
✅ Los macros permiten generar código automáticamente en tiempo de compilación, reduciendo errores y simplificando el desarrollo. Son especialmente útiles en Swift para reducir código repetitivo y mejorar la seguridad. 🚀

### 🔹 Diferencia entre un Macro y un Property Wrapper
| Característica      | Macro (`#macro`)                | Property Wrapper (`@propertyWrapper`) |
|---------------------|--------------------------------|--------------------------------------|
| 📌 **Cuándo actúa** | En tiempo de compilación      | En tiempo de ejecución             |
| 🔧 **Qué hace**    | Genera código nuevo antes de compilar | Modifica el comportamiento de propiedades en ejecución |
| 📌 **Ejemplo**      | `#double(10)` → se expande a `20` | `@State var count = 0` |

## 4. ¿Qué significa `tiempo de compilación` vs. `tiempo de ejecución`?
Son dos momentos diferentes en el ciclo de vida de un programa:

### 🔹 Fases de ejecución en Swift
| **Fase**              | **¿Cuándo ocurre?** | **Ejemplo** |
|----------------------|--------------------|-------------|
| ⏳ **Tiempo de compilación** | Antes de ejecutar el programa, mientras Xcode convierte tu código en una app ejecutable. | Errores de sintaxis, macros, y optimización del código ocurren aquí. |
| ⚡ **Tiempo de ejecución** | Cuando la app ya está en funcionamiento en el iPhone, iPad o simulador. | Cualquier acción del usuario, como tocar un botón o recibir una respuesta de un servidor. |

✅ En resumen:
• Tiempo de compilación → Errores que detecta Xcode antes de ejecutar la app.
• Tiempo de ejecución → Errores o acciones que ocurren cuando la app ya está corriendo. 🚀

## 5. ¿Qué hace `@Environment(ModelData.self) var modelData` y `.environment(ModelData())`? Diferencia entre `@Environment()` y `@State`
• `@Environment` es un `property wrapper` en SwiftUI que permite acceder a datos compartidos en el entorno de la app.
• `ModelData.self` indica que estamos accediendo a una instancia de `ModelData` que ya está almacenada en el entorno de SwiftUI.

🔹 Conclusión
✔️ `@Environment(ModelData.self)` permite que la vista `LandmarkList` acceda a datos globales sin pasarlos como parámetros.
✔️ `.environment(ModelData())` inyecta la instancia para que esté disponible en todo el entorno de SwiftUI.
✔️ Evita el uso de `@State` o `@ObservedObject` en cada vista, haciendo el código más limpio.

🚀 Este patrón es útil para compartir datos en toda la app, como configuraciones, autenticación o listas de objetos.

### 🔄 Diferencia entre `@Environment()` y `@State`

+ La diferencia clave entre:
- `@State var vm: ViewModelDta = ViewModelDta()`
- `@Environment(ViewModelDta.self) var vm`
es cómo se `maneja el estado y la compartición de datos` en SwiftUI.

+ Si defines `VM con @State`, significa que cada vez que se `crea vista`, se genera `una nueva instancia de VM`. Esto rompe la sincronización entre `diferentes vistas`, porque cada una `tendría su propio VM` en lugar de compartir la misma instancia global.

Cada vista tendría su propio `conjunto de datos separado`, y los cambios en una `vista no afectarían` a las demás.

+ `@Environment(ViewModelDta.self)` permite inyectar una instancia compartida de `ModelData` en la vista.

1. Con `.environment(ModelData())` Een `ContentView` o en `#Preview` se pasa una `única instancia` de `ViewModelDta`
2. Todas las vistas que usan `@Environment(ViewModelDta.self) var vm` acceden a la `misma instancia`, lo que permite que los cambios sean visibles en toda la app.

+ Ejemplo práctico de por qué `@Environment` es mejor (dependiendo del caso)
Supongamos que `VModelData` tiene una `lista de favoritos`, y el usuario marca un `lugar` como `favorito` en la pantalla de detalle.
❌ Con `@State var modelData = ModelData()`
Cada vista tiene su `propia copia de VModelData`, por lo que marcar un `Lugar como favorito en LandmarkDetail` no actualizaría la `lista en Lugares`.

✅ Con `@Environment(ModelData.self) var modelData`
Todas `las vistas comparten la misma instancia`, así que `cualquier cambio` se refleja automáticamente en toda la app.

+ Regla general:
• Usa `@State` para estados `locales y privados`. Un estado privado que `solo cambia` dentro de `una vista`.
 `@State` funciona bien cuando el estado es `local` y solo afecta a una `vista específica`.
• Usa `@Environment` para datos `globales y compartidos` en toda la app. Compartir datos entre `múltiples vistas`. `@Environment` es mejor cuando necesitas `compartir el estado` entre varias vistas.

💡 Por eso, en este ejemplo `@Environment(ModelData.self)` es la opción correcta.

## 6. ¿Qué hace `@Bindable`? Diferencia entre `@Bindable` y `@Binding`
`@Bindable` es un `Property Wrapper` introducido en `Swift 5.9` y `SwiftUI 5`, que facilita la gestión de datos observables cuando se usa con `Observable` en lugar de `ObservableObject`. Permite que una propiedad se enlace de manera más eficiente a la interfaz de usuario sin necesidad de usar `@StateObject, @ObservedObject, o @EnvironmentObject.`

1. `@Bindable`: Permite que `vmModelData` se enlace automáticamente a la vista.
2. `var vm = vmModelData`: Está creando una variable enlazable a partir de la propiedad `@Environment(VmModelData.self) var vmModelData`

✅ Resumen
1.	`@Bindable` reemplaza `@ObservedObject y @EnvironmentObject` en muchos casos.
2.	Necesita que el objeto (`VmModelData`) sea @`Observable`, no `@ObservableObject`.
3.	Mejora el rendimiento al manejar cambios de estado de manera más eficiente en `SwiftUI`.

### 🔄 Diferencias entre `@Bindable` y `@Binding`
- `@Binding`: se usa cuando pasamos una propiedad de una `vista padre a una vista hija` para que la hija pueda modificarla.

- `@Bindable`: se usa cuando queremos conectar + observable (`@Observable`) a la vista.
Aquí, `isOn` pertenece a `ModelData`, y `@Bindable` permite que `la vista` lo use de forma eficiente sin necesidad de `@ObservedObject`.

| **Característica**  | **@Bindable**  | **@Binding**  |
|---------------------|---------------|--------------|
| 📌 **Propósito**  | Conecta un modelo observable a la vista.  | Conecta una propiedad individual a otra vista.  |
| 🏗 **Dónde se usa**  | Con `@Observable` para manejar datos compartidos.  | Para pasar una variable mutable entre vistas.  |
| 📍 **¿Necesita `@State` o `@Observable`?**  | Sí, requiere que el modelo sea `@Observable`.  | Sí, normalmente se enlaza a una propiedad `@State`.  |
| 🔗 **Cómo funciona**  | Convierte un objeto en un modelo enlazable.  | Solo enlaza una propiedad específica a otra vista.  |
| 🛠 **Ejemplo de uso**  | `@Bindable var modelData = modelData`  | `@Binding var isOn: Bool`  |

# ___________________________ SECCIÓN 2 `DIBUJO Y ANIMACIÓN` ___________________________

# ..................... PROYECTO:`4_DrawingPathsAndShapes` .....................
Sigue estando la aplicacion de `la sección 1`. Lo que se `ha añadido` va a aparte es como diseñar y crear un insignia (Badge) con un  `fondo hexagonal`  y `símbolos rotados` en su interior con `curvas de Bézier` usando Path, desarrollado en la carpeta `Badges`.

- `Historia` de las `curvas de Bézier`: han sido ampliamente usadas en los gráficos generados por ordenador para modelado de curvas suaves. Como la curva está completamente contenida en la envolvente convexa de los puntos de control, dichos puntos pueden ser visualizados gráficamente sobre el área de trabajo y usados para manipular la curva de una forma muy intuitiva. Las transformaciones afines tales como traslaciones y rotaciones pueden ser aplicadas, con gran facilidad, a las curvas, aplicando las transformaciones respectivas sobre los puntos de control.

Ficheros:
1️⃣ `HexagonParameters` - Define los puntos del hexágono
2️⃣ `BadgeBackground` - Dibuja el hexágono
3️⃣ `BadgeSymbol` - Dibuja el símbolo interno
4️⃣ `RotatedBadgeSymbol` - Rota el símbolo
5️⃣ `Badge` - Ensambla todo

## 1. ¿Para qué sirve `Path`?
• Path permite `dibujar formas personalizadas` en SwiftUI.
• Se usa en este ejemplo para definir los `bordes de un hexágono` y `dibujar curvas de Bézier`.
• `Combina líneas` (`addLine`) y `curvas` (`addQuadCurve`) para lograr `formas complejas`.

### Métodos de `Path` en SwiftUI para `crear una figura`
| Método | Descripción |
|--------|------------|
| `move(to:)` | Define el punto de inicio. |
| `addLine(to:)` | Dibuja una línea recta. |
| `addQuadCurve(to:control:)` | Dibuja una curva con un solo punto de control. |
| `addCurve(to:control1:control2:)` | Dibuja una curva con dos puntos de control. |
| `addArc(center:radius:startAngle:endAngle:clockwise:)` | Dibuja un arco circular. |
| `addRect(_:)` | Dibuja un rectángulo. |
| `addEllipse(in:)` | Dibuja una elipse o círculo. |
| `closeSubpath()` | Cierra la forma automáticamente. |

🚀 Conclusión: `Path` se usa aquí para `construir formas personalizadas` como el `hexágono` y el `símbolo de la insignia`, controlando cada punto y curva con precisión.

# ..................... PROYECTO:`5_AnimatingViewsAndTransitions` .....................
Se crea la carpeta `Hikes` y un nuevo swifton de `hikeData` para añadir un nuevo modelo `Hike` y en el repositorio `ModelData` obtener tambien los datos en forma de objeto (tipo array de `Hike` de la fuente del swifton `hikeData`).

De hay se pasa ya a la carpeta `Hikes`:
1️⃣ `HikeView` - Esta utilizando una transición personalizada con `AnyTransition` para animar la aparición y desaparición de `HikeDetail`, combinando e`fectos de movimiento y desvanecimiento`. También estás aprovechando las `animaciones asimétricas` para diferenciar la forma en que la vista aparece y desaparece.
2️⃣ `HikeGraph` - utilizando `KeyPath` de manera inteligente para `generar gráficos dinámicos` para diferentes métricas de Hike.Observation, y además aplicas animaciones personalizadas.
3️⃣ `GraphCapsule` - Utiliza `Range<Double>` y cálculos proporcionales para `renderizar cápsulas escaladas` y desplazadas correctamente en función de los datos.
4️⃣ `HikeDetail` - Unir en una misma vista `HikeGraph` con los botones de acciones.

## 1. `Transición dinámica` personalizada dependiendo de la acción.
```swift
        // FUERA DE LA VISTA....
        static var moveAndFade: AnyTransition {
                .asymmetric(
                    insertion: .move(edge: .trailing).combined(with: .opacity),
                    removal: .scale.combined(with: .opacity)
                )
            }

        // DENTRO DE LA VISTA....
        HikeDetail(hike: hike) // Subview for the detail
                    .transition(.moveAndFade) // Animacion de transición (extraida arriba declarada)
```

¿Cómo funciona esto?
+ `.asymmetric(...)`: permite definir transiciones diferentes para cuando una vista:
1. Aparece (`insertion`): en este caso, se mueve desde el borde derecho y aparece gradualmente `(.move(edge: .trailing).combined(with: .opacity))`
2. Desaparece (`removal`): se encoge y se desvanece (`.scale.combined(with: .opacity)`).

# ___________________________ SECCIÓN 3 `DISEÑO Y DISPOSICIÓN` ___________________________

# ..................... PROYECTO:`6_ComposingComplexInterfaces` .....................
Se divide en un `TabView` con dos secciones (`tabItem`). La segunda `tabItem` contendra todo la app hecha hasta el momento con el listado y filtro de favoritos y la navegación a detalles de cada lugar.

Y la primera `tabItem` va a mostrar una pantalla mas bonita categorizando los lugar con imagenes y a lo que se va a poder acceder (navegando) tambien a la pantalla de detalles de cada lugar.

Se modifcian los archivso:
- `Landmark`: añadido variable de `isFeatured` (bool - destacado) y `category` (enum - categoria)
- `ModelData`: se añade `propiedad computada` par aobtener los lugares solo filtrados con el campo `isFeatured` (destacado) a true. Y un `diccionario` que `agrupa` los landmarks por `categoría`.
- `ContentView`: `TabView` con las dos salidas en unos `tabItem`

Se crea la carpeta `Category`:
1️⃣ `CategoryHome` - listato vertical dividido en secciones horizontales por categorias.
2️⃣ `CategoryRow` - 'listado' horizontal para una seccion en especifico de categoria.
3️⃣ `CategoryItem` - elemento que conforma para cada 'listado' horizontal.

## 1. `Agrupar` un `array de diccionario` por `tipo de campos` de forma directa
```swift
var categories: [String: [Landmark]] {
    Dictionary(
        grouping: landmarks, // Array de landmarks.
        by: { $0.category.rawValue } // Agrupa por la categoría de cada landmark.
    )
}
```

1. `grouping`:
• Toma el array landmarks (un `array de objetos` Landmark).
• Agrupa los elementos del array en `subarrays` según un criterio.
2. `by`:
• Define cómo `agrupar los elementos`.
• En este caso, se `agrupa usando la categoría` (category.rawValue) de cada Landmark.

## 2. ¿Qué hace `.listRowInsets(EdgeInsets())`?
• `Elimina el padding` predeterminado de `los elementos de la lista`.
• De forma predeterminada, SwiftUI aplica `un espaciado` alrededor de cada `fila en una List`. Usando EdgeInsets() lo establece en cero, haciendo que el contenido ocupe todo el ancho disponible.

## 3. ¿Qué hace `showsIndicators: false`?
En un ScrollView en SwiftUI controla la `visibilidad` de las `barras de desplazamiento`.

```swift
ScrollView(.horizontal, showsIndicators: false) {
    // Contenido desplazable
}
```

1. `showsIndicator: false`: Oculta las barras de desplazamiento.
2. `showsIndicators: true` (valor predeterminado): Muestra las barras de desplazamiento.

## 4. ¿Por qué usar `.renderingMode(.original)`?
En SwiftUI, `.renderingMode(.original)` se utiliza para mostrar una imagen con sus colores originales, en lugar de aplicarle el tinte (tint) predeterminado de la vista que la contiene.

Si no se especifica el modo de renderizado, SwiftUI puede aplicar el color de acento o el tinte de la vista padre a la imagen, especialmente si es un símbolo de SF Symbols o una imagen con colores transparentes.

Por ejemplo:
• `Sin .renderingMode(.original)`: La imagen puede aparecer en azul (u otro color de acento definido).
• `Con .renderingMode(.original)`: La imagen mantiene sus colores naturales.

```swift
landmark.image
    .renderingMode(.original)
    .resizable()
    .frame(width: 155, height: 155)
    .cornerRadius(5)
```

Aquí se asegura de que la imagen del landmark:
• Se muestre tal cual fue diseñada, sin aplicar ningún tinte de color.
• Se haga resizable para adaptarse al tamaño especificado.
• Tenga esquinas redondeadas con .cornerRadius(5).

# ..................... PROYECTO:`7_WorkingWithUIControls` .....................
Añade este nuevo proyecto una pantalla de un perfil de usuario que se abre como un sheet y te permite visualizar todos los datos del usuario aparte de los Badges (insignias creados con forma geométrica) y Hikes (caminatas con gráficas animadas), que son caracteristicas que vimos y creamos en otras secciones.
Los datos personales tambien se podran editar enviando a una nueva pantalla y pudiendo modificarlos.

1️⃣ `Profile`: modelo donde defino un perfil de usuario.
2️⃣ `ProfileSummary`: muestra los datos del usuario y los Badges (como `HikeBadge`) y Hikes.
3️⃣ `HikeBadge`: muestra un Badge con titulo
4️⃣ `ProfileEditor`: es como  un formulario para que el usuario edite sus campos
5️⃣ `ProfileHost`: se cuenta la info de `ProfileSummary` y añade un botón para acceder y editar

Modificado:
+ `CategoryHome`: añadir el boton para aaceder al perfil del usuario.

## 1. Sección perfil usuario en `.toolbar` de la `list`
`Toolbar` en la `List` ideal para poner un botón icono para acceder a la `pantalla de perfil`.

```swift
    List {

         }
         .toolbar { // Un conjunto de botones que se muestran en la barra de herramientas de la vista.
            Button {
                showingProfile.toggle()
            } label: {
                Label("User Profile", systemImage: "person.crop.circle")
            }
         }
```

# 2. Modo edición en un a vista `@Environment(\.editMode) var editMode` y botón `EditButton()`
`SwiftUI` proporciona almacenamiento en el entorno para los valores a los que puede acceder utilizando el `@Environment` envoltorio de propiedad. Anteriormente usaste @Environment para recuperar una clase que almacenó en el entorno.

`@Environment(\.editMode)` se utiliza para detectar y controlar si una `vista` está en `modo de edición o modo de visualización`. Este es un patrón común cuando quieres alternar entre un `estado editable` y uno de `solo lectura` en tu interfaz de usuario.

```swift
@Environment(\.editMode) var editMode
```

Esto crea una variable llamada `editMode` que observa el `estado de edición` de la vista.
• Se utiliza `@Environment` para leer y modificar valores del `entorno global` de SwiftUI, como `el modo de edición`.
• `editMode` es un Optional (`EditMode?`), por eso se usa `?.wrappedValue.`

🎨 Estados de `EditMode`
• `.active`: La vista está en modo de edición (editable).
• `.inactive`: La vista está en modo de visualización (solo lectura).

- `¿Qué es EditButton()?`
Es un componente de SwiftUI que automáticamente alterna editMode entre:
• `.active` (modo de edición)
• `.inactive` (modo de visualización)

Cree un botón `EditButton()` hace que alterne el modo edición o visualización `.editMode`
```swift
 HStack {
            if editMode?.wrappedValue == .active {
                Button("Cancel", role: .cancel) {
                    draftProfile = modelData.profile // Restablece los cambios (draftProfile = modelData.profile).
                    editMode?.animation().wrappedValue = .inactive // Desactiva el modo de edición (editMode?.wrappedValue = .inactive).
                }
            }

             Spacer()

            EditButton() // Es el boton `Edit un botón predeterminado de SwiftUI que alterna automáticamente entre .active e .inactive.
        }

        if editMode?.wrappedValue == .inactive { // Si está en .inactive:

                ProfileSummary(profile: modelData.profile) // Se muestra ProfileSummary, que es solo de lectura.

            } else {

                ProfileEditor(profile: $draftProfile) // Se muestra ProfileEditor, que permite editar el perfil.

                //....
            }
```

# 3. Crear un `rango de fechas` (`ClosedRange<Date>`)
```swift
var dateRange: ClosedRange<Date> {
    let min = Calendar.current.date(byAdding: .year, value: -1, to: profile.goalDate)!
    let max = Calendar.current.date(byAdding: .year, value: 1, to: profile.goalDate)!
    return min...max
}
```

Este fragmento de código en `Swift` crea un rango de fechas (`ClosedRange<Date>`) que va un año antes y un año después de una fecha llamada `profile.goalDate`.

`let min = Calendar.current.date(byAdding: .year, value: -1, to: profile.goalDate)!`
• Utiliza Calendar.current.date(byAdding:...) para restar un año a profile.goalDate.
• `.year`: Especifica que el ajuste se hará en años.
• `value: -1`: Resta 1 año.
• `to`: profile.goalDate: La fecha de referencia es profile.goalDate.
• `!`: Se fuerza el desempaquetado, asumiendo que siempre se obtendrá una fecha válida.

# ___________________________ SECCIÓN 4 `INTEGRACIÓN DEL FRAMEWORK` ___________________________

# ..................... PROYECTO:`8_InterfacingWithUIKit` .....................
Se añade funcionamiento para representar `vistas UIKit` y controladores de vista en `SwiftUI`.

Ficheros nuevos (en carpeta `PageView`):
- `PageViewController`
- `PageControl`
- `PageView`
- `FeatureCard`

Ficheros modificados:
- `Landmark`
- `CategoryHome`

# 1. Protócolo `UIViewControllerRepresentable`
`UIViewControllerRepresentable` es un protocolo que permite usar controladores de vista de UIKit (UIViewController) dentro de una vista SwiftUI.

`SwiftUI` no tiene todas las funcionalidades de `UIKit`. A veces, necesitas usar un UIViewController porque:
✅ No hay una alternativa en SwiftUI (Ejemplo: UIImagePickerController para la cámara).
✅ Quieres reutilizar código existente en UIKit.
✅ Necesitas una funcionalidad avanzada (Ejemplo: UIPageViewController para paginación).

Cuando creas una vista basada en `UIViewControllerRepresentable`, debes implementar al menos dos métodos obligatorios
```swift
protocol UIViewControllerRepresentable {
    associatedtype UIViewControllerType: UIViewController

    // Crea y devuelve el UIViewController de UIKit que usará SwiftUI.
    func makeUIViewController(context: Context) -> UIViewControllerType
    // Actualiza la vista cuando SwiftUI detecta cambios.
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context)
}
```

- ¿Qué protocolo utiliza para unir los controladores de vista UIKit a SwiftUI? `UIViewControllerRepresentable` que sirve para crear una estructura que se ajuste a implementar los requisitos del protocolo para incluir en su jerarquía de vista.

- ¿En qué método crea un delegado o fuente de datos para un tipo `UIViewControllerRepresentable`?
En el método `makeCoordinator() context` parámetro en otros métodos requeridos.

# 2. Protócolo `UIViewRepresentable`
`UIViewRepresentable` permite usar vistas de UIKit (UIView) dentro de SwiftUI.
Su estructura es similar a `UIViewControllerRepresentable`, pero para `vistas` en lugar de `controladores`.

```swift
protocol UIViewRepresentable {
    associatedtype UIViewType: UIView

    // Crea y configura la vista UIKit (UIPageControl).
    func makeUIView(context: Context) -> UIViewType

    // Actualiza la vista cuando SwiftUI detecta cambios.
    func updateUIView(_ uiView: UIViewType, context: Context)
}
```

# 3. `PageView` en `SwiftUI`
Esta vista combina `PageViewController (paginación deslizante)` y `PageControl` (indicador de páginas con puntitos) en un solo componente reutilizable.

# 4. 🚀 Conceptos Clave Finales

✅ `UIViewControllerRepresentable` y `UIViewRepresentable` permiten usar `UIKit` en `SwiftUI`.
✅ Coordinator maneja la interacción entre `SwiftUI` y `UIKit`.
✅ `@State` y `@Binding` permiten la comunicación entre vistas.
✅ `UIPageViewController` permite deslizamiento entre páginas.
✅ `UIPageControl` muestra el estado de la paginación.

🔹 Uso típico: Carruseles de imágenes, introducciones (Onboarding), secciones deslizables.

# ..................... PROYECTO:`9_CreatingAwatchOSApp` .....................
Crear un `target` para la ejecución en el `Apple Watch` dentro del proyecto que ya llevamos hecho.

- Seleccionar: `File --> New --> Target --> wartchOS (Application - App)`
- Elegir opción: `Watch App for Existing iOS App`
- Dentro del Target ya creado de WatchOS: `Deployments Info --> (Seleccionar) Supports Running Without iOS App Installation`

Lo nuevo se encuentra en la carpeta `WatchLandmarks Watch App` pero antes de llegar aqui tenemos que realizar `unos pasos` para pasarle `algunos de los ficheros` que no se modifican `al target` tambien de `Apple Watch`.

- Eliminar el fichero de `punto de entrada` para la aplicación watchOS, es la `xxxxApp.swift`
- Seleccionar los modelos, repositorios,  VM, vistas (ficheros) que nuestra aplicación puede mostrar igualmente en iOS que en WatchOS. Al seleccionarlo saldra a la derecha la opción de `Target Membership` en la cual tenemos que añadir el nuevo `target del WatchOS`.
- Añadir en el `Assets` los imagenes necesarias.

Apartir de aqui ya solo quedaria `crear los archivos` que no se han importado porque no son `compatibles con el WatchOS` como pueden ser las `vistas` con muchos detalles que ocupen mucho. En cada archivo a la hora de crearlo te va a preguntar a que target quieres y tienes que seleccionar solo al de `WatchOS`.

# 1. Cree una interfaz de notificación personalizada

1. `ContentView.swift`
```swift
import UserNotifications

 LandmarkList() // vista
            .task { // se solicita permiso para notificaciones usando UNUserNotificationCenter.
                let center = UNUserNotificationCenter.current() // pide permiso para mostrar: alertas, sonidos, badges en el ícono de la app.
                _ = try? await center.requestAuthorization( // try? await sugiere que la autorización podría fallar, pero no detendrá la ejecución.
                    options: [.alert, .sound, .badge]
                )
            }
```

✅ ¿Qué hace este código?
- 1. Solicita `permiso para notificaciones` en `ContentView`.
- 2. Define una vista de notificación (`NotificationView`) que muestra información sobre un landmark.
- 3. Procesa las `notificaciones push` en `NotificationController`, extrayendo datos del `userInfo` de la notificación.
- 4. Usa un `payload JSON` para enviar información sobre un landmark a través de una notificación push.

2. `NotificationView.swift`
Es una vista normal y corriente

- Es la `vista` que se muestra cuando llega `una notificación push`.

3. `NotificationController.swift (watchOS)`

```swift
import WatchKit
import UserNotification

class NotificationController: WKUserNotificationHostingController<NotificationView> {
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
```

• `NotificationController` maneja la llegada de notificaciones push en un Apple Watch.
• Hereda de `WKUserNotificationHostingController<NotificationView>`, lo que significa que usa `NotificationView` como su interfaz de usuario.

4. `PushNotificationPayload.json` es un `json` creado con desde `watchOS --> Resource --> Notification Simulation File`
```json
{
    "aps": {
        "alert": {
            "title": "Silver Salmon Creek",
            "body": "You are within 5 miles of Silver Salmon Creek."
        },
        "category": "LandmarkNear",
        "thread-id": "5280"
    },

    "landmarkIndex": 1,

    "Simulator Target Bundle": "com.example.apple-samplecode.Landmarks.watchkitapp"
}
```

Este es un ejemplo `JSON` de una notificación push que el servidor enviaría a la app.

📌 Claves importantes:
• `aps.alert` → Contiene el título y mensaje de la notificación.
• `category` → Define una categoría personalizada de la notificación (LandmarkNear).
• `thread-id` → Agrupa notificaciones relacionadas en una misma conversación.
• `landmarkIndex` → Indica qué landmark específico se debe mostrar en la notificación.

Se supone...
📌 ¿Cuándo debería aparecer la notificación?
1. Cuando el servidor envía una notificación push con el payload JSON correcto.
2. Cuando la app está cerrada o en segundo plano en el Apple Watch.
3. Cuando la notificación push está correctamente configurada en el Xcode y en el dispositivo.

# ..................... PROYECTO:`10_CreatingAmacOSApp` .....................
Añadir otra sección para tener la aplicación tambien para dispositivos `macOS`.

Crear un `target` para la ejecución en el `macOs` dentro del proyecto que ya llevamos hecho.

- Seleccionar: `File --> New --> Target --> macOs (Application - App)`

Lo nuevo se encuentra en la carpeta `MacLandmarksApp` pero antes de llegar aqui tenemos que realizar `unos pasos` para pasarle `algunos de los ficheros` que no se modifican `al target` tambien de `MacOS`.

- Eliminar el fichero de `punto de entrada` para la aplicación watchOS, es la `xxxxApp.swift`
- Seleccionar los modelos, repositorios,  VM, vistas (ficheros) que nuestra aplicación puede mostrar igualmente en iOS que en WatchOS. Incluir el  en el `Assets` los imagenes necesarias. Al seleccionarlo saldra a la derecha la opción de `Target Membership` en la cual tenemos que añadir el nuevo `target del MacOS`.

Apartir de aqui ya solo quedaria `crear los archivos` que no se han importado porque no son `compatibles con el MacOS` como pueden ser las `vistas` con muchos detalles que ocupen mucho. En cada archivo a la hora de crearlo te va a preguntar a que target quieres y tienes que seleccionar solo al de `MacOS`.

# 1. Botón par abrir la app de `mapas de Apple`.
```swift
 Button("Open in Maps") {
                    // Open the Maps app with the destination set to the landmark location.
                    let destination = MKMapItem(placemark: MKPlacemark(coordinate: landmark.locationCoordinate)) // Se crea un objeto MKMapItem, que representa un lugar en Apple Maps.
                    destination.name = landmark.name // Se le da un name (el nombre del landmark).
                    destination.openInMaps() // Se llama a .openInMaps(), que abre la app de Apple Maps con la ubicación configurada.
                }
```

# 2. Alineaciones `personalización`.
```swift
ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) { ...}

VStack(alignment: .leading, spacing: 20) { ... }

.offset(y: -50) // desplaza el contenido 50 puntos hacia arriba.
```

# 3. `Habilitar opciones` según para que `sistema operativo` va a ser.
```swift
 #if !os(watchOS) //  Esta línea excluye la siguiente sección de código en watchOS.
        .commands { // Se usa para agregar comandos en la barra de menú en macOS o acciones específicas en iOS/iPadOS.
            LandmarkCommands() // Un struct que define comandos personalizados en la app.
        }
        #endif
```

# 4. Crear `comandos del teclado` para realizar acciones.
En la vista principal de la App `LandmarksApp`:
```swift
#if !os(watchOS)
.commands {
    LandmarkCommands()
}
#endif
```

La vista `LandmarkCommands`:
```swift
struct LandmarkCommands: Commands { // Protocolo Commands permite agregar atajos de teclado y menús en macOS.
    @FocusedBinding(\.selectedLandmark) var selectedLandmark // Obtiene un binding ($selectedLandmark) a la selección actual del usuario.

    var body: some Commands {

        SidebarCommands() // DE APPLE: Agrega comandos estándar de la barra lateral de macOS (mostrar/ocultar).

        CommandMenu("Landmark") {
            /**
            	•	Si un Landmark está seleccionado, muestra un botón para marcarlo o desmarcarlo como favorito.
                •	"Mark as Favorite" si no es favorito.
                •	"Remove as Favorite" si ya lo es.
            */

            Button("\(selectedLandmark?.isFavorite == true ? "Remove" : "Mark") as Favorite") {
                selectedLandmark?.isFavorite.toggle()
            }
            .keyboardShortcut("f", modifiers: [.shift, .option]) // Atajo de teclado: Shift + Option + F
            .disabled(selectedLandmark == nil) // Desactiva el botón si no hay un Landmark seleccionado.
        }
    }
}

// Define una clave personalizada (FocusedValueKey) para almacenar la selección de un Landmark.
private struct SelectedLandmarkKey: FocusedValueKey {
    typealias Value = Binding<Landmark> // El valor almacenado es un Binding<Landmark> (permite modificarlo directamente).
}

extension FocusedValues { //  El valor almacenado es un Binding<Landmark> (permite modificarlo directamente).
    var selectedLandmark: Binding<Landmark>? {
        get { self[SelectedLandmarkKey.self] } // El valor almacenado es un Binding<Landmark> (permite modificarlo directamente).
        set { self[SelectedLandmarkKey.self] = newValue } // Permite modificar el valor almacenado.
    }
}

```

# 5. `Agregar preferencias` con una escena de `configuración`.
En la vista principal de la App `LandmarksApp`:
```swift
#if os(macOS)
    Settings {
        LandmarkSettings()
    }
 #endif
```

Eso simplemente es una vista con un picker para la configuración `LandmarkSettings`:
```swift
struct LandmarkSettings: View {

    @AppStorage("MapView.zoom") // Guarda y recupera el nivel de zoom del mapa en almacenamiento persistente (UserDefaults). "MapView.zoom" es la clave donde se guarda la preferencia. 
    private var zoom: MapView.Zoom = .medium // Valor inicial predeterminado (.medium).

    var body: some View {

        Form { // crea una interfaz tipo formulario.
            Picker("Map Zoom:", selection: $zoom) { // permite seleccionar el nivel de zoom.
                ForEach(MapView.Zoom.allCases) { level in
                    Text(level.rawValue)
                }
            }
            .pickerStyle(.inline)
        }
        .frame(width: 300)
        .navigationTitle("Landmark Settings")
        .padding(80)
    }
}
```


