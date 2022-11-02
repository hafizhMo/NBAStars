//
//  UDManager.swift
//  NBAStars
//
//  Created by Hafizh Mo on 02/11/22.
//

import Foundation

extension UserDefaults {
    private enum UDKeys: String {
        case version
    }
    
    var version: String? {
        get {
            string(forKey: UDKeys.version.rawValue)
        }
        set {
            setValue(newValue, forKey: UDKeys.version.rawValue)
        }
    }
}
