//
//  Extensions.swift
//  BauBuddyVERO
//
//  Created by Murat on 9.11.2023.
//

import UIKit

extension UIViewController {
    
    func showErrorAlert(error: NetworkError) {
           let alertController = UIAlertController(title: "Error", message: error.errorDescription, preferredStyle: .alert)
           alertController.addAction(UIAlertAction(title: "OK", style: .default))
           present(alertController, animated: true)
       }
}

extension UIColor {

    convenience init(hexString: String) {

        var hexColor: String = hexString._removeWhiteSpace.uppercased()

        if hexColor.hasPrefix("#") {
            hexColor.remove(at: hexColor.startIndex)
        }

        if (hexColor.count) != 6 {
            self.init(
                red: 0 / 255.0,
                green: 0 / 255.0,
                blue: 0 / 255.0,
                alpha: 1
            )
        }

        var rgbValue: UInt64 = 0
        Scanner(string: hexColor).scanHexInt64(&rgbValue)

        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

}

extension String {
    
    var _hexColor: UIColor {
        return UIColor.init(named: self) ?? UIColor.init(hexString: self)
    }
    
    var _removeWhiteSpace: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

