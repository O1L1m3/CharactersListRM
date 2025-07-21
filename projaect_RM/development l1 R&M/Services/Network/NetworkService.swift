//  Created by Emilio

import Foundation

protocol INetworkService {
    func fetchData(status: String?, gender: String?) async throws -> [CharacterRM]
}

struct NetworkService: INetworkService {
    
    func fetchData(status: String?, gender: String?) async throws -> [CharacterRM] {
        var allCharacters: [CharacterRM] = []
        var page = 1

        while true {
            let urlString = "https://rickandmortyapi.com/api/character"

            var queryItems: [URLQueryItem] = [URLQueryItem(name: "page", value: String(page))]
            if let status, !status.isEmpty {
                queryItems.append(URLQueryItem(name: "status", value: status.lowercased()))
            }
            if let gender, !gender.isEmpty {
                queryItems.append(URLQueryItem(name: "gender", value: gender.lowercased()))
            }

            var urlComponents = URLComponents(string: urlString)!
            urlComponents.queryItems = queryItems

            let url = urlComponents.url!
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode(ResultRM.self, from: data)

            allCharacters.append(contentsOf: decodedResponse.results)

            if decodedResponse.info.next == nil {
                break
            }

            page += 1
        }

        return allCharacters
    }
}
