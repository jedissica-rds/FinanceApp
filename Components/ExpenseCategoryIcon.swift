import SwiftUI

struct ExpenseCategoryIcon: View {
    
    let category: Expense.Category
    var size = 36.0
    var radius = 8.0
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: radius)
                .fill(category.backgroundColor)
            
            Image(systemName: category.icon)
                .foregroundStyle(.white)
        }
        .frame(width: size, height: size)
    }
}

#Preview {
    HStack {
        ExpenseCategoryIcon(category: .food)
        ExpenseCategoryIcon(category: .transportation)
        ExpenseCategoryIcon(category: .housing)
        ExpenseCategoryIcon(category: .healthcare)
        ExpenseCategoryIcon(category: .entertainment)
        ExpenseCategoryIcon(category: .education)
        ExpenseCategoryIcon(category: .miscellaneous)
    }
}
