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
        navigationBar.isHidden = true
    }
}
