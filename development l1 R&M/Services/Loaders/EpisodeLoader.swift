//  Created by Emilio

import Foundation

@MainActor
final class EpisodeLoader: ObservableObject {
    @Published var episodes: [Episode] = []

    func loadEpisodes(from urls: [String]) async {
        await MainActor.run {
            episodes = []
        }

        for urlString in urls {
            guard let url = URL(string: urlString) else { continue }

            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let episode = try JSONDecoder().decode(Episode.self, from: data)
                
                await MainActor.run {
                    if !episodes.contains(where: { $0.id == episode.id }) {
                        episodes.append(episode)
                    }
                }
            } catch {
                print("Ошибка загрузки эпизода: \(error.localizedDescription)")
            }
        }
    }

}
