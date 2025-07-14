//  Created by Emilio

import Foundation
import CoreData

class FavoritesManager: ObservableObject {
    @Published var favoriteCharacters: [CharacterRM] = []
    private let viewContext = PersistenceController.shared.container.viewContext

    init() {
        loadFavorites()
    }

    func addFavorite(character: CharacterRM) {
        if !isFavorite(character: character) {
            let newFavorite = FavoriteCharacter(context: viewContext)
            newFavorite.id = Int32(character.id)
            newFavorite.name = character.name
            newFavorite.status = character.status
            newFavorite.species = character.species
            newFavorite.gender = character.gender
            newFavorite.image = character.image

            saveContext()
            loadFavorites()
        }
    }

    func removeFavorite(character: CharacterRM) {
        let fetchRequest: NSFetchRequest<FavoriteCharacter>
        fetchRequest = FavoriteCharacter.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", character.id)

        do {
            let results = try viewContext.fetch(fetchRequest)
            if let characterToDelete = results.first {
                viewContext.delete(characterToDelete)
                saveContext()
                loadFavorites()
            }
        } catch {
            print("Error deleting favorite: \(error)")
        }
    }

    func removeAllFavorites() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = FavoriteCharacter.fetchRequest()
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try viewContext.execute(batchDeleteRequest)
            saveContext()
            loadFavorites()
        } catch {
            print("Error removing all favorites: \(error)")
        }
    }

    func isFavorite(character: CharacterRM) -> Bool {
        favoriteCharacters.contains(where: { $0.id == character.id })
    }

    private func loadFavorites() {
        let request: NSFetchRequest<FavoriteCharacter> = FavoriteCharacter.fetchRequest()
        do {
            let coreDataCharacters = try viewContext.fetch(request)
            favoriteCharacters = coreDataCharacters.map { coreDataCharacter in
                CharacterRM(
                    id: Int(coreDataCharacter.id),
                    name: coreDataCharacter.name!,
                    status: coreDataCharacter.status!,
                    species: coreDataCharacter.species!,
                    gender: coreDataCharacter.gender!,
                    image: coreDataCharacter.image!
                )
            }
        } catch {
            print("Error fetching favorites: \(error)")
        }
    }

    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
