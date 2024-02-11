//
//  ImageLoader.swift
//  RickAndMorty
//
//  Created by ARDA BUYUKHATIPOGLU on 11.02.2024.
//

import UIKit

final class RMImageLoader {
    static let shared = RMImageLoader()
        
    private var imageDataCache = NSCache<NSString, NSData>()
    
    private init() {}
    
    
    /**
     Downloads an image from the specified URL asynchronously.

     - Parameters:
        - url: The URL from which to download the image.
        - completion: A closure to be executed when the download completes. It takes a `Result` enum with a `Data` value on success and an `Error` value on failure.

     - Note: This function uses a cache to store downloaded image data to improve performance.

     - Warning: This function does not handle caching logic for URLs that may change or require cache invalidation. It relies on the URL string as the cache key, which may not be suitable for all cases.
     */
    public func downloadImage(_ url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        let key = url.absoluteString as NSString
        if let cachedImageData = imageDataCache.object(forKey: key) {
            completion(.success(cachedImageData as Data))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            
            let valueToCache = data as NSData
            self?.imageDataCache.setObject(valueToCache, forKey: key)
            
            completion(.success(data))
        }
        task.resume()
    }
}
