import UIKit
import SwiftUI

extension UIFont {
    // Ниже приведены примеры шрифтов, настоящие шрифты надо взять из фигмы

    // Headline Fonts
    static var headline1 = UIFont.systemFont(ofSize: 34, weight: .bold)
    static var headline2 = UIFont.systemFont(ofSize: 28, weight: .bold)
    static var headline3 = UIFont.systemFont(ofSize: 22, weight: .bold)
    static var headline4 = UIFont.systemFont(ofSize: 20, weight: .bold)

    // Body Fonts
    static var bodyRegular = UIFont.systemFont(ofSize: 17, weight: .regular)
    static var bodyBold = UIFont.systemFont(ofSize: 17, weight: .bold)

    // Caption Fonts
    static var caption1 = UIFont.systemFont(ofSize: 15, weight: .regular)
    static var caption2 = UIFont.systemFont(ofSize: 13, weight: .regular)
}

extension Font {
    static var headline1: Font { Font(UIFont.headline1) }
    static var headline2: Font { Font(UIFont.headline2) }
    static var headline3: Font { Font(UIFont.headline3) }
    static var headline4: Font { Font(UIFont.headline4) }
    
    static var bodyRegular: Font { Font(UIFont.bodyRegular) }
    static var bodyBold: Font { Font(UIFont.bodyBold) }
    
    static var caption1: Font { Font(UIFont.caption1) }
    static var caption2: Font { Font(UIFont.caption2) }
}
