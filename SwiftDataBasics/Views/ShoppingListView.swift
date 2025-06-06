//
//  ContentView.swift
//  SwiftDataBasics
//
//  Created by Dennis on 06.06.25.
//

import SwiftUI
import SwiftData


struct ShoppingListView: View {
    /*
    @Query(filter: #Predicate<ShoppingItem>{ item in
        !item.isCompleted
    })
     */
    @Query(sort:
            [SortDescriptor(\ShoppingItem.createdAt)])
    var items: [ShoppingItem]
   // @Query(sort: \ShoppingItem.createdAt) var items: [ShoppingItem]
    
    @Environment(\.modelContext) private var context
    @State private var showingAddItem = false
    @State private var newItemName = ""
    @State private var selectedCategory = "Allgemein"
    
    let categories = ["Allgemein", "Obst & Gemüse", "Fleisch & Fisch", "Milchprodukte", "Getränke", "Süßwaren"]
    
    var body: some View {
        NavigationStack {
            VStack {
                // Statistiken
                
                    HStack {
                        StatCard(title: "Gesamt", value: "\(items.count)")
                        StatCard(title: "Erledigt", value: "\(completedCount)")
                        StatCard(title: "Offen", value: "\(openCount)")
                    }
                    .padding()
                
                
                
                List {
                    ForEach(items) { item in
                        ShoppingItemRow(item: item)
                            .swipeActions(edge: .trailing) {
                                Button("Löschen", role: .destructive) {
                                    deleteItem(item)
                                }
                                .tint(.red)
                            }
                            .swipeActions(edge: .leading) {
                                Button(item.isCompleted ? "Offen" : "Erledigt") {
                                    toggleCompletion(item)
                                }
                                .tint(item.isCompleted ? .orange : .green)
                            }
                    }
                    
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Einkaufsliste")
            .toolbar {
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddItem = true
                    } label:{
                        Image(systemName: "plus")
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    if !items.isEmpty {
                        Button("Alle löschen") {
                            deleteAllItems()
                        }
                        .foregroundColor(.red)
                    }
                }
            }
            .sheet(isPresented: $showingAddItem) {
                AddItemView(categories: categories)
            }
        }
    }
    
    // Berechnete Properties
    var completedCount: Int {
        items.filter { $0.isCompleted }.count
    }
    
    var openCount: Int {
        items.filter { !$0.isCompleted }.count
    }
    
    // Funktionen
    func deleteItem(_ item: ShoppingItem) {
        context.delete(item)
        try? context.save()
    }
        
    func toggleCompletion(_ item: ShoppingItem) {
        item.isCompleted.toggle()
        try? context.save()
    }
    
    func deleteAllItems() {
        for item in items {
            context.delete(item)
        }
        try? context.save()
    }
}

#Preview {
    ShoppingListView()
        .modelContainer(for: ShoppingItem.self, inMemory: true)
}
