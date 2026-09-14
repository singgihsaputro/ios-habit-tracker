import Foundation

enum MockHabitRepositoryError: Error {
    case fixtureNotFound
}

/// Reads habits from the bundled `habits.json` fixture. A future networked
/// implementation of `HabitRepository` can replace this one without any
/// changes to the view model or views.
struct MockHabitRepository: HabitRepository {
    func loadHabits() async throws -> [Habit] {
        #if SWIFT_PACKAGE
        let bundle = Bundle.module
        #else
        let bundle = Bundle.main
        #endif
        guard let url = bundle.url(forResource: "habits", withExtension: "json") else {
            throw MockHabitRepositoryError.fixtureNotFound
        }
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode([Habit].self, from: data)
    }
}
