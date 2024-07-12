/*
 See LICENSE folder for this sample’s licensing information.
 */

import SwiftUI

enum Theme: String, CaseIterable, Identifiable, Codable {

    case bubblegum
    case indigo
    case magenta
    case orange
    case purple
    case seafoam
    case sky
    case yellow
    
    var accentColor: Color {
        switch self {
        case .bubblegum, .orange, .seafoam, .sky, .yellow: return .black
        case .indigo, .magenta, .purple: return .white
        }
    }
    var mainColor: Color {
        return switch self {
        case .bubblegum:
            Color.pink
        case .indigo:
            Color.indigo
        case .magenta:
            Color.red
        case .orange:
            Color.orange
        case .purple:
            Color.purple
        case .seafoam:
            Color.cyan
        case .sky:
            Color.blue
        case .yellow:
            Color.yellow
        }
    }
    var themeName: String {
        rawValue.capitalized
    }
    var id: String {
        themeName
    }
}
