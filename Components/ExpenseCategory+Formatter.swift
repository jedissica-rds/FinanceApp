import SwiftUI

extension Expense.Category {
    var backgroundColor: Color {
        switch self {
            case .food: .red
            case .transportation: .orange
            case .housing: .brown
            case .healthcare: .green
            case .entertainment: .purple
            case .education: .blue
            case .miscellaneous: .gray
        }
    }
    
    var icon: String {
        switch self {
            case .food: "cup.and.heat.waves.fill"
            case .transportation: "car.fill"
            case .housing: "house.fill"
            case .healthcare: "cross.case.fill"
            case .entertainment: "movieclapper.fill"
            case .education: "book.fill"
            case .miscellaneous: "creditcard.fill"
        }
    }
    
    var displayText: String {
        rawValue.capitalized
    }
}
