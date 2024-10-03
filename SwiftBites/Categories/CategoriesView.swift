import SwiftUI
import SwiftData

struct CategoriesView: View {
    @Environment (\.modelContext) var modelContext
    @Query private var categories: [RecipeCategory]
    @State private var query = ""
    
    init(query: String = "") {
        self._query = State(initialValue: query)
        let predicate = #Predicate<RecipeCategory> { category in
            query.isEmpty || category.name.localizedStandardContains(query)
        }
        
        self._categories = Query(filter: predicate, sort: \RecipeCategory.name, animation: .bouncy)
    }
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Categories")
                .toolbar {
                    if !categories.isEmpty {
                        NavigationLink(value: CategoryForm.Mode.add) {
                            Label("Add", systemImage: "plus")
                        }
                    }
                }
                .navigationDestination(for: CategoryForm.Mode.self) { mode in
                    CategoryForm(mode: mode)
                }
                .navigationDestination(for: RecipeForm.Mode.self) { mode in
                    RecipeForm(mode: mode)
                }
        }
    }
    
    // MARK: - Views
    
    @ViewBuilder
    private var content: some View {
        if categories.isEmpty {
            empty
        } else {
            list(for: categories.filter {
                if query.isEmpty {
                    return true
                } else {
                    return $0.name.localizedStandardContains(query)
                }
            }
            )
        }
    }
    
    var empty: some View {
        ContentUnavailableView(
            label: {
                Label("No Categories", systemImage: "list.clipboard")
            },
            description: {
                Text("Categories you add will appear here.")
            },
            actions: {
                NavigationLink("Add Category", value: CategoryForm.Mode.add)
                    .buttonBorderShape(.roundedRectangle)
                    .buttonStyle(.borderedProminent)
            }
        )
    }
    
    private var noResults: some View {
        ContentUnavailableView(
            label: {
                Text("Couldn't find \"\(query)\"")
            }
        )
    }
    
    private func list(for categories: [RecipeCategory]) -> some View {
        ScrollView(.vertical) {
            if categories.isEmpty {
                noResults
            } else {
                LazyVStack(spacing: 10) {
                    ForEach(categories) { category in
                        CategorySection(category: category)
                    }
                }
            }
        }
        .searchable(text: $query)
    }
}

#Preview{CategoriesView()}
