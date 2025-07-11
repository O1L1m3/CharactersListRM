//  Created by Emilio

import Foundation

protocol NetworkService {
    func fetchData(species: String, gender: String, completion: @escaping (ResultRM) -> Void)
}

struct NetworkLayer: NetworkService {

    func fetchData(species: String, gender: String, completion: @escaping (ResultRM) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "rickandmortyapi.com"
        urlComponents.path = "/api/character/"

        urlComponents.queryItems = [
            URLQueryItem(name: "species", value: species),
            URLQueryItem(name: "gender", value: gender)
        ]

        guard let url = urlComponents.url else {
            print(URLError.badURL)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { data, _, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }

            guard let data = data else {
                print(URLError.dataNotAllowed)
                return
            }

            do {
                let character = try JSONDecoder().decode(ResultRM.self, from: data)
                completion(character)
            } catch {
                print(error.localizedDescription)
            }

        }.resume()
    }
}
