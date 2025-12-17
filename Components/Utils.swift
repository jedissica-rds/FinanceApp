import SwiftUI

extension FormatStyle {
    public static func dollar<Value>() -> Self where Self == FloatingPointFormatStyle<Value>.Currency, Value : BinaryFloatingPoint {
        return .currency(code: "USD")
    }
}

extension Dictionary where Key == Expense.Category, Value == [Expense] {
    func toCategorySummaries() -> [CategorySummary] {
        map { category in
            CategorySummary(
                category: category.key,
                expensesCount: category.value.count,
                amount: category.value.reduce(0, { $0 + $1.amount })
            )
        }
    }
}
