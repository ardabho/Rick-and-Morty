//
//  APICaller.swift
//  test
//
//  Created by Arda Büyükhatipoğlu on 1.12.2023.
//

import Foundation

struct APICaller {
    
    enum NetworkError: Error {
        case badURL
        case cantConvertToString
    }
    
    static func fetchData(page: Int?, completion: @escaping (Result<CharacterResponse, Error>) -> Void) {
        
        guard let url = URL(string: "https://rickandmortyapi.com/api/character/?page=\(page ?? 1)") else {
            completion(.failure(NetworkError.badURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data, error == nil else {
                completion(.failure(error!))
                return
            }
            
            do {
                let decodedObject = try JSONDecoder().decode(CharacterResponse.self, from: data)
                completion(.success(decodedObject))
                
            } catch let DecodingError.dataCorrupted(context) {
                print(context)
                
            } catch let DecodingError.keyNotFound(key, context) {
                print("\n\nKey '\(key)' not found:", context.debugDescription)
                print("\ncodingPath:", context.codingPath)
                
            } catch let DecodingError.valueNotFound(value, context) {
                print("\n\nValue '\(value)' not found:", context.debugDescription)
                print("\ncodingPath:", context.codingPath)
                
            } catch let DecodingError.typeMismatch(type, context)  {
                print("\n\nType '\(type)' mismatch:", context.debugDescription)
                print("\ncodingPath:", context.codingPath)
                
            } catch {
                print("error: ", error)
            }
            
        }.resume()
        
    }

}
