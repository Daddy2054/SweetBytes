import SwiftUI
import SwiftData

@main
struct SwiftBitesApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Ingredient.self,
            RecipeIngredient.self,
            RecipeCategory.self,
            Recipe.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
