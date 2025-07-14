//  Created by Emilio


//  Created by Emilio

import Foundation

protocol INetworkService {
    // Изменено: теперь fetchData может принимать URL напрямую для обработки пагинации
    func fetchData(url: URL?, gender: String?, status: String?, completion: @escaping (ResultRM) -> Void)
}

struct NetworkService: INetworkService {
    func fetchData(url: URL?, gender: String?, status: String?, completion: @escaping (ResultRM) -> Void) {
        let baseUrlString = "https://rickandmortyapi.com/api/character"
        
        // Определяем URL для запроса
        let finalUrl: URL
        if let providedUrl = url {
            // Если URL предоставлен (для следующей страницы), используем его
            finalUrl = providedUrl
        } else {
            // Если URL не предоставлен, строим его с нуля с учетом пола и статуса
            var components = URLComponents(string: baseUrlString)!
            var queryItems = [URLQueryItem]()
        
            if let gender = gender {
                queryItems.append(URLQueryItem(name: "gender", value: gender))
            }
            
            if let status = status {
                queryItems.append(URLQueryItem(name: "status", value: status))
            }
            
            components.queryItems = queryItems.isEmpty ? nil : queryItems
            
            guard let constructedUrl = components.url else {
                print("Invalid URL")
                return
            }
            finalUrl = constructedUrl
        }
        
        guard !finalUrl.absoluteString.isEmpty else {
            print("Final URL is empty.")
            return
        }

        URLSession.shared.dataTask(with: finalUrl) { data, response, error in // Используем finalUrl
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


//import Foundation
//
//protocol INetworkService {
//    func fetchData(gender: String?, status: String?, completion: @escaping (ResultRM) -> Void)
//}
//
//struct NetworkService: INetworkService {
//    func fetchData(gender: String?, status: String?, completion: @escaping (ResultRM) -> Void) {
//        var components = URLComponents(string: "https://rickandmortyapi.com/api/character")!
//        var queryItems = [URLQueryItem]()
//    
//        if let gender = gender {
//            queryItems.append(URLQueryItem(name: "gender", value: gender))
//        }
//        
//        if let status = status {
//            queryItems.append(URLQueryItem(name: "status", value: status))
//        }
//        
//        components.queryItems = queryItems.isEmpty ? nil : queryItems
//        
//        guard let url = components.url else {
//            print("Invalid URL")
//            return
//        }
//        
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            if let error = error {
//                print("Error fetching data: \(error)")
//                return
//            }
//            
//            guard let data = data else {
//                print("No data received")
//                return
//            }
//            
//            do {
//                let decodedResponse = try JSONDecoder().decode(ResultRM.self, from: data)
//                completion(decodedResponse)
//            } catch {
//                print("Error decoding data: \(error)")
//            }
//        }.resume()
//    }
//}
