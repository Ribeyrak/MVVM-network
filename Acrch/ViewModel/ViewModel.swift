//
//  InputViewModel.swift
//  Acrch
//
//  Created by Evhen Lukhtan on 20.02.2023.
//

import Foundation
import Combine

class CommentListViewModel {
    
    @Published var comments = [Comments]()
    private let networkManager = NetworkManager()
    var cancellables = Set<AnyCancellable>()
    
    var lower: String
    var upper: String
    
    init(lower: String, upper: String) {
        self.lower = lower
        self.upper = upper
    }
    
//    func fetchData(start: Int, end: Int) {
//        guard let url = URL(string: "https://jsonplaceholder.typicode.com/comments?_start=\(start)&_end=\(end)") else { return }
//
//        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
//            guard let data = data else { return }
//            do {
//                let userModels = try JSONDecoder().decode([Comments].self, from: data)
//                self.comments = userModels
//            }
//            catch {
//
//            }
//        }
//        task.resume()
//    }
    
    // Submit comments
    func fetchData() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/comments?_start=\(lower)&_end=\(upper)") else { return }

        networkManager.fetchData(from: url) { result in
            switch result {
            case .success(let data):
                do {
                    let comments = try JSONDecoder().decode([Comments].self, from: data)
                    self.comments = comments
                } catch {
                    print("Failed to decode JSON: \(error.localizedDescription)")
                }
            case .failure(let error):
                print("Error fetching data: \(error.localizedDescription)")
            }
        }
    }
    
    // Pagination comments
    func fetchDataWithPagination(limit: Int) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/comments?_limit=\(limit)") else { return }

        networkManager.fetchData(from: url) { result in
            switch result {
            case .success(let data):
                do {
                    let comments = try JSONDecoder().decode([Comments].self, from: data)
                    self.comments = comments
                } catch {
                    print("Failed to decode JSON: \(error.localizedDescription)")
                }
            case .failure(let error):
                print("Error fetching data: \(error.localizedDescription)")
            }
        }
    }
    
    func getAllComments() {
        guard let irl = URL(string: "https://jsonplaceholder.typicode.com/comments") else { return }
        
        networkManager.fetchData(from: irl) { reslt in
            switch reslt {
            case .success(let dat):
                do {
                    let com = try JSONDecoder().decode([Comments].self, from: dat)
                    self.comments = com
                } catch {
                    print("putin xuylo")
                }
                
            case .failure(let err):
                print("error fethc: \(err.localizedDescription)")
            }
        }
    }
    
    func getNComments(limit: Int) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/comments?_limit=\(limit)") else { return }

        networkManager.fetchData(from: url) { result in
            switch result {
            case .success(let data):
                do {
                    let newComments = try JSONDecoder().decode([Comments].self, from: data)
                    self.comments.append(contentsOf: newComments)
                    print(url)
                } catch {
                    print("Failed to decode JSON: \(error.localizedDescription)")
                }
            case .failure(let error):
                print("Error fetching data: \(error.localizedDescription)")
            }
        }
    }
}

