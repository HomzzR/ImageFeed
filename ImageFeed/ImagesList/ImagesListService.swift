//
//  ImagesListService.swift
//  ImageFeed
//
//  Created by Артем Калюжин on 10.09.2023.
//

import UIKit
import Kingfisher

final class ImagesListService {
    // MARK: - Properties
    
    private (set) var photos: [Photo] = []
    
    private var lastLoadedPage: Int?
    private var task: URLSessionTask?
    private let urlSession = URLSession.shared
    private let dateFormatter = ISO8601DateFormatter()
    static let DidChangeNotification = Notification.Name(rawValue: "ImagesListServiceDidChange")
    let tokenStorage = OAuth2TokenStorage()

    // MARK: - Functions
    
    func fetchPhotosNextPage() {
        guard task == nil else {return}
        let nextPage = (lastLoadedPage ?? 0) + 1
        
        var urlComponents = URLComponents(string: "https://api.unsplash.com")
        urlComponents?.path = "/photos"
        urlComponents?.queryItems = [
            URLQueryItem(name: "page", value: "\(nextPage)")
        ]
        
        guard let url = urlComponents?.url else { return }
        
        var request = URLRequest(url: url)
        guard let token = tokenStorage.token else {return}
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let dataTask = urlSession.objectTask(for: request) { [weak self] (result: Result<[PhotoResult], Error>) in
            guard let self = self else { return }
            print(result)
            switch result {
            case .success(let photoResults):
                DispatchQueue.main.async {
                    for photoResult in photoResults {
                        self.photos.append(self.convertPhoto(photoResult))
                    }
                    NotificationCenter.default.post(
                        name: ImagesListService.DidChangeNotification,
                        object: nil)
                    self.lastLoadedPage = nextPage
                    self.task = nil
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print("Failed to fetch photos:", error)
                    self.task = nil
                }
            }
        }
        task = dataTask
        task?.resume()
    }
    
    private func convertPhoto(_ photoResult: PhotoResult) -> Photo {
        let createdAt = photoResult.createdAt ?? ""
        let size = CGSize(width: photoResult.width, height: photoResult.height)

        let photo = Photo(id: photoResult.id,
                          size: size,
                          createdAt: dateFormatter.date(from: createdAt),
                          welcomeDescription: photoResult.description,
                          thumbImageURL: photoResult.urls.thumb,
                          largeImageURL: photoResult.urls.full,
                          likedByUser: photoResult.likedByUser
        )
        return photo
    }
    
    func changeLike(photoId: String, isLike: Bool, _ completion: @escaping (Result<Void, Error>) -> Void) {
        var urlComponents = URLComponents(string: "https://api.unsplash.com")
        urlComponents?.path = "/photos/\(photoId)/like"
        
        guard let url = urlComponents?.url else {return}
        
        var request = URLRequest(url: url)
        guard let token = tokenStorage.token else {return}
        request.httpMethod = isLike ? "POST" : "DELETE"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let dataTask = urlSession.objectTask(for: request) { [weak self] (result: Result<LikeResult, Error>) in
            guard let self = self else {return}
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    if let index = self.photos.firstIndex(where: {$0.id == photoId}) {
                        let photo = self.photos[index]
                        let newPhoto = Photo(
                            id: photo.id,
                            size: photo.size,
                            createdAt: photo.createdAt,
                            welcomeDescription: photo.welcomeDescription,
                            thumbImageURL: photo.thumbImageURL,
                            largeImageURL: photo.largeImageURL,
                            likedByUser: !photo.likedByUser
                        )
                        self.photos[index] = newPhoto
                        completion(.success(()))
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
        dataTask.resume()
    }
}

