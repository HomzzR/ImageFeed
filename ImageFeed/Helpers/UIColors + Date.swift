//
//  UIColors.swift
//  ImageFeed
//
//  Created by Артем Калюжин on 14.07.2023.
//

import UIKit

private  let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd MMMM yyyy"
    formatter.dateStyle = .medium
    formatter.timeStyle = .none
    return formatter
} ()

extension Date {
    var dateTimeString: String {
        var dateString = dateFormatter.string(from: self)
        dateString = dateString.replacingOccurrences(of: "г.", with: "")
        return dateString
    }
}

extension UIColor {
    static var ypWhiteA: UIColor { UIColor(named: "YP White_A") ?? UIColor.white }
    static var ypRed: UIColor { UIColor(named: "YP Red") ?? UIColor.red }
    static var ypBlack: UIColor { UIColor(named: "YP Black") ?? UIColor.black}
    static var ypBackground: UIColor { UIColor(named: "YP Background") ?? UIColor.darkGray }
    static var ypGray: UIColor { UIColor(named: "YP Gray") ?? UIColor.gray }
    static var ypWhite: UIColor { UIColor(named: "YP White") ?? UIColor.white }
    static var ypBlue: UIColor { UIColor(named: "YP Blue") ?? UIColor.blue }
 }



