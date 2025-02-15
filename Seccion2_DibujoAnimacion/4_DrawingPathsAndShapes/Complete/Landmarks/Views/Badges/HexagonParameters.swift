/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
Size, position, and other information used to draw a badge.
*/

import CoreGraphics

// Define los segmentos del hexágono con puntos de líneas y curvas.
struct HexagonParameters {
    
    // Cree una estructura para mantener los segmentos del hexagono
    // Cada lado del hexágono tiene una línea (line), una curva (curve) y un punto de control (control).
    struct Segment {
        let line: CGPoint
        let curve: CGPoint
        let control: CGPoint
    }

    // Pequeño ajuste para suavizar la forma del hexágono.
    static let adjustment: CGFloat = 0.085
    
    // Cree una matriz para mantener segmentos. Un segmento para cada lado del hexágono, es decir un total de 6 segmentos.
    static let segments = [
        Segment(
            line:    CGPoint(x: 0.60, y: 0.05),
            curve:   CGPoint(x: 0.40, y: 0.05),
            control: CGPoint(x: 0.50, y: 0.00)
        ),
        Segment(
            line:    CGPoint(x: 0.05, y: 0.20 + adjustment),
            curve:   CGPoint(x: 0.00, y: 0.30 + adjustment),
            control: CGPoint(x: 0.00, y: 0.25 + adjustment)
        ),
        Segment(
            line:    CGPoint(x: 0.00, y: 0.70 - adjustment),
            curve:   CGPoint(x: 0.05, y: 0.80 - adjustment),
            control: CGPoint(x: 0.00, y: 0.75 - adjustment)
        ),
        Segment(
            line:    CGPoint(x: 0.40, y: 0.95),
            curve:   CGPoint(x: 0.60, y: 0.95),
            control: CGPoint(x: 0.50, y: 1.00)
        ),
        Segment(
            line:    CGPoint(x: 0.95, y: 0.80 - adjustment),
            curve:   CGPoint(x: 1.00, y: 0.70 - adjustment),
            control: CGPoint(x: 1.00, y: 0.75 - adjustment)
        ),
        Segment(
            line:    CGPoint(x: 1.00, y: 0.30 + adjustment),
            curve:   CGPoint(x: 0.95, y: 0.20 + adjustment),
            control: CGPoint(x: 1.00, y: 0.25 + adjustment)
        )
    ]
}
