//
//  Extensions.swift
//  iOS_valorant_agent
//
//  Created by Yahia Ewida on 2/8/21.
//

import Foundation
import SwiftUI

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
}

extension UINavigationController {
    open override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.standardAppearance.configureWithTransparentBackground()
    }
}

extension Color {
    static var abilityImageBackgroundColor = Color(red: 34/255, green: 47/255, blue: 68/255)
    static var abilityBackgroundColor = Color(red: 17/255, green: 26/255, blue: 39/255)

    static var characterColors: [Color] {
        return [
            Color(red: 112/255, green: 123/255, blue: 109/255),
            Color(red: 113/255, green: 133/255, blue: 140/255),
            Color(red: 147/255, green: 147/255, blue: 119/255),
            Color(red: 134/255, green: 139/255, blue: 147/255),
            Color(red: 154/255, green: 147/255, blue: 148/255),
            Color(red: 116/255, green: 159/255, blue: 134/255),
            Color(red: 142/255, green: 173/255, blue: 101/255),
            Color(red: 131/255, green: 131/255, blue: 131/255),
            Color(red: 131/255, green: 132/255, blue: 140/255),
            Color(red: 87/255, green: 90/255, blue: 165/255),
            Color(red: 128/255, green: 172/255, blue: 162/255),
            Color(red: 122/255, green: 119/255, blue: 124/255),
            Color(red: 131/255, green: 133/255, blue: 168/255),
            Color(red: 131/255, green: 133/255, blue: 168/255)
        ]
    }
}
