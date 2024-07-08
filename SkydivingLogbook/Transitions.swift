import SwiftUI

// Extension for transitions
extension AnyTransition {
    static var rotateAndFade: AnyTransition {
        AnyTransition.modifier(
            active: RotateAndFadeModifier(amount: 90, opacity: 0),
            identity: RotateAndFadeModifier(amount: 0, opacity: 1)
        )
    }
}

// Rotation and fade specifics
struct RotateAndFadeModifier: ViewModifier {
    let amount: Double
    let opacity: Double

    func body(content: Content) -> some View {
        content
            .rotation3DEffect(.degrees(amount), axis: (x: 1, y: 1, z: 1))
            .opacity(opacity)
    }
}
