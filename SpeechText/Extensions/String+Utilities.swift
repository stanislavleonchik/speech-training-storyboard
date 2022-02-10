//
//  String+Utilities.swift
//

import UIKit

extension String {
    var attributed: NSAttributedString {
        NSAttributedString(string: self, attributes: [.font: UIFont.systemFont(ofSize: 14)])
    }
}
