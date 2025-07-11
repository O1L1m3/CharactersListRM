//  Created by Emilio

import Foundation

protocol INetworkService {
    func fetchData(gender: String?, status: String?, completion: @escaping (ResultRM) -> Void)
}

struct NetworkService: INetworkService {
    func fetchData(gender: String?, status: String?, completion: @escaping (ResultRM) -> Void) {
        var components = URLComponents(string: "https://rickandmortyapi.com/api/character")!
        var queryItems = [URLQueryItem]()
    
        if let gender = gender {
            queryItems.append(URLQueryItem(name: "gender", value: gender))
        }
        
        if let status = status {
            queryItems.append(URLQueryItem(name: "status", value: status))
        }
        
        components.queryItems = queryItems.isEmpty ? nil : queryItems
        
        guard let url = components.url else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(ResultRM.self, from: data)
                completion(decodedResponse)
            } catch {
                print("Error decoding data: \(error)")
            }
        }.resume()
    }
}
