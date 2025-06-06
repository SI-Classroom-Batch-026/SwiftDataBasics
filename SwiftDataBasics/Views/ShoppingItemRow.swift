//
//  ShoppingItemRow.swift
//  SwiftDataBasics
//
//  Created by Dennis on 06.06.25.
//

import SwiftUI

struct ShoppingItemRow: View {
    let item: ShoppingItem
    @Environment(\.modelContext) private var context
    
    var body: some View {
        HStack {
            // Checkbox
            Button{
                item.isCompleted.toggle()
                try? context.save()
            }label: {
                Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(item.isCompleted ? .green : .gray)
                    .font(.title2)
            }
            .buttonStyle(PlainButtonStyle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(item.name)
                    .font(.headline)
                    .strikethrough(item.isCompleted)
                    .foregroundColor(item.isCompleted ? .gray : .primary)
                
                HStack {
                    Text(item.category)
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(8)
                    
                    Spacer()
                    
                    Text(item.createdAt, style: .date)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            
            Spacer()
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    let shoppingItemDummy = ShoppingItem(name: "Water")
    ShoppingItemRow(item: shoppingItemDummy)
}
