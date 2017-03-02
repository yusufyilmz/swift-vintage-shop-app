//
//  String+Numeric.swift

import Foundation

extension String {
    func isNumericString() -> Bool {
        
        let nonDigitChars = CharacterSet.decimalDigits.inverted
        
        let string = self as NSString
        
        if string.rangeOfCharacter(from: nonDigitChars).location == NSNotFound {
            // definitely numeric entierly
            return true
        }
        
        return false
    }
}
