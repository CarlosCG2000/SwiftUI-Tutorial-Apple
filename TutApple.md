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
Añada un listado a través de un json con varios lugares (ya no solo hay uno) a los que poder acceder navegando por la lista y navegar a cada lugar con más detalles (la vista de detalles del lugar que se creo en el anterior proyecto).

## 1. Visualizar varios `Previews` en un mismo fichero
Se pueden definir varios `Previews` y darles un nombre para identificarlos como `#Preview("Un elemento") { ... }` y en el dispositivo en la parte superior salen las opciones de las `Previews` para elegir cual  queremos ver.

## 2. Lista `estática` pasar a lista `dinámica`
Esto es una lista estática:
```js
        List {
            ForEach(episodes) { episodeItem in
            ...
            }
        }
```

Esto es una lista dinámica (más óptimo que la estática):
```js
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
```js
    @State private var position: MapCameraPosition = .region(region)

    Map(position: $position) // El usuario puede cambiar la posición
```

🚫 Con .constant() (fijo, sin cambios)
```js
    Map(position: .constant(.region(region))) // No permite cambios
```

🔹 ¿Cuándo usar cada uno?
• Usa .`constant()` si no quieres que la posición del mapa cambie.
• Usa `@State` y `$binding` si quieres que el usuario pueda interactuar con el mapa.

Si quieres que el usuario mueva el mapa y recuerde la posición, usa @State. Si solo quieres mostrar una ubicación fija, usa .constant(). 🚀

# ..................... PROYECTO:`3_HandlingUserInput` .....................
Añadir poder seleccionar lugares favoritos (se ha añadido el campo tambien en el json) y que se muestre tanto en los detalles del lugar como en el listado pudiendo filtrar para ver solo el listado con los favoritos.

## 1. ¿Por qué `@State` debe ser `private`?
📌 1️⃣ `@State` es `específico de una vista`
`@State` se usa para datos internos de una `vista` y sus `subvistas`. SwiftUI gestiona su `ciclo de vida`, por lo que si lo expusieras públicamente, otras vistas podrían modificarlo de forma `no controlada`, lo que rompería `la reactividad del sistema`.

📌 2️⃣ Se `evita` que otras vistas lo `modifiquen directamente`
Si `@State` fuera público, podrías modificarlo desde fuera de la vista, lo que haría que la actualización del estado fuera `menos predecible`.

📌 3️⃣ Se usa `Binding` cuando otra vista necesita acceder al estado
Si una vista hija necesita modificar un `@State`, en lugar de hacerlo público, pasas un `Binding` para que solo acceda a la `referencia controlada`.

✅ Estado privado con `@State`
```js
struct ParentView: View {
    @State private var showFavoritesOnly = false

    var body: some View {
        ChildView(isFavorite: $showFavoritesOnly) // Pasamos un Binding
    }
}
```

🚀 Vista secundaria con `Binding`
```js
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

```js
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
```js
let number = #double(21)  // Se expande a: let number = 42
```

📌 2. Expansión de `Declaraciones` (`@MyMacro`)
Se usa en `declaraciones` como funciones, structs o clases.

```js
@Observable // Genera automáticamente código para hacer seguimiento de cambios en una clase
class User {
    var name: String
}
```

📌 3. Expansión de `Membros` (`#MemberMacro`)
Añade propiedades o métodos automáticamente a una estructura o clase.
```js
struct Persona {
    #addLogging
}
```

Esto podría generar automáticamente métodos como:
```js
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
Sigue estando la aplicacion de `la sección 1`. Lo que se `ha añadido` va a aparte es como diseñar y crear un icono en la carpeta `Badges`.

