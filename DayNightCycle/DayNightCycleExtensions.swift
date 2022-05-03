//
//  DayNightCycleLottieView.swift
//  Animations
//
//  Created by Loic D on 15/04/2022.
//

import SwiftUI
import Lottie

extension LottieView {

    func playCycle(isDay: Bool) {
        animationView.play(fromProgress: isDay ? 0.5 : 0, toProgress: isDay ? 1 : 0.5)
    }
    
    func pauseAnimation() {
        animationView.pause()
    }
}

extension AnyTransition {
    /*
    static var slideAndOpactiy: AnyTransition {
        AnyTransition.opacity.combined(with: AnyTransition.slide)
    }
     */
    static func slideAndOpactiy() -> AnyTransition {
        let insertion = AnyTransition.slide
            .animation(Animation.linear(duration: 3).delay(2))
        /*.combined(with: AnyTransition.opacity)
            .animation(Animation.linear(duration: 3).delay(2))*/
         let removal = AnyTransition.slide
            .animation(Animation.linear(duration: 3))
            .combined(with: AnyTransition.opacity)
            .animation(Animation.linear(duration: 3))
         return .asymmetric(insertion: insertion, removal: removal)
    }
}
/*
extension SwiftUI.Animation {
    static func slideAndOpactiy(comingIn: Bool) -> SwiftUI.Animation {
        Animation.linear(duration: 5).delay(comingIn ? 4 : 0)
    }
}
*/

