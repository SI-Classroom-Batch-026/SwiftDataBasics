//
//  AddItemView.swift
//  SwiftDataBasics
//
//  Created by Dennis on 06.06.25.
//

import SwiftUI

struct AddItemView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @State private var itemName = ""
    @State private var selectedCategory = "Allgemein"
    
    let categories: [String]
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Artikel Details")) {
                    TextField("Artikel Name", text: $itemName)
                    
                    Picker("Kategorie", selection: $selectedCategory) {
                        ForEach(categories, id: \.self) { category in
                            Text(category)
                        }
                    }
                }
                
                Section {
                    Button("Hinzufügen") {
                        addItem()
                    }
                    .disabled(itemName.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
            .navigationTitle("Neuer Artikel")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Abbrechen") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    func addItem() {
        let newItem = ShoppingItem(name: itemName.trimmingCharacters(in: .whitespaces),
                                 category: selectedCategory)
        context.insert(newItem)
        try? context.save()
        dismiss()
    }
}

#Preview {
    AddItemView(categories: ["Drinks", "Snacks"])
}
