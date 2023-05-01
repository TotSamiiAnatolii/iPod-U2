//
//  Colors.swift
//  iPod U2 AudioPlayer
//
//  Created by APPLE on 14.03.2023.
//

import UIKit

enum Colors {

    static let newDisplayColor: UIColor = #colorLiteral(red: 0.9942041201, green: 1, blue: 0.986237429, alpha: 1)
    
    static let shadowDisplayColor: CGColor = #colorLiteral(red: 0.3312136776, green: 0.3538864809, blue: 0.3218994991, alpha: 1).cgColor
    
    static let controlModule: UIColor = #colorLiteral(red: 0.7803921569, green: 0.1093301586, blue: 0.1270790009, alpha: 1)

    static let borderDisplayColor: CGColor = UIColor.white.cgColor

    static let borderColor: UIColor = #colorLiteral(red: 0.1829668087, green: 0.2217157496, blue: 0.3078191764, alpha: 1)
    
    //MARK: - Color for navBar
    static let topColorNavBar = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
    
    static let bottomColorNavBar = #colorLiteral(red: 0.8907980307, green: 0.8907980307, blue: 0.8907980307, alpha: 1).cgColor

    //MARK: - Color for gradientLayer
    static let backTop: CGColor = #colorLiteral(red: 0.8064520055, green: 0.8064520055, blue: 0.8064520055, alpha: 1).cgColor
    
    static let backWhite: CGColor = UIColor.white.cgColor
    
    static let backMiddle: CGColor = #colorLiteral(red: 0.8460944521, green: 0.8460944521, blue: 0.8460944521, alpha: 1).cgColor
    
    static let backBottom: CGColor = UIColor.white.cgColor

    static let progreesTop: CGColor = #colorLiteral(red: 0, green: 0.2532890872, blue: 0.7186652602, alpha: 1).withAlphaComponent(0.7).cgColor
    
    static let progressWhite: CGColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
    
    static let progressMiddle: CGColor = #colorLiteral(red: 0.4748130957, green: 0.6746731763, blue: 0.9027803635, alpha: 1).withAlphaComponent(0.8).cgColor
    
    static let progressBottom: CGColor = #colorLiteral(red: 0.1896464388, green: 0.5434677445, blue: 0.8291940368, alpha: 1).withAlphaComponent(0.8).cgColor
    
}
