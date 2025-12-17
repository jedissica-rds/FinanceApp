import Foundation

struct Expense {
    let id: String
    let date: Date
    let description: String
    let amount: Double
    let category: Category
}

extension Expense {
    enum Category: String, Decodable, CaseIterable {
        case food
        case transportation
        case housing
        case healthcare
        case entertainment
        case education
        case miscellaneous
    }
}

extension Expense: Decodable {}
extension Expense: Identifiable {}

extension Expense {
    static func new() -> Expense {
        .init(
            id: UUID().uuidString,
            date: Date(),
            description: "",
            amount: 0,
            category: .miscellaneous
        )
    }
}
