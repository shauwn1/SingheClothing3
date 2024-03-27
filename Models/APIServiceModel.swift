//
//  APIServiceModel.swift
//  SingheClothing
//
//  Created by Shehara Jayasooriya on 2024-03-24.
//

import Foundation
class ApiService {
    private let baseURL = "http://localhost:3000/api"
    
    func fetchProducts(forCategory category: String, completion: @escaping ([ClothingItem]?) -> Void) {
        let formattedCategory = category.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        guard let url = URL(string: "\(baseURL)/products/\(formattedCategory)") else {
            DispatchQueue.main.async {
                completion(nil)
            }
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching products: \(error)")
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            guard let data = data else {
                print("No data received")
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            do {
                let products = try JSONDecoder().decode([ClothingItem].self, from: data)
                DispatchQueue.main.async {
                    completion(products)
                }
            } catch {
                print("Failed to decode products: \(error)")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }.resume()
    }
    
    
    
    
    func fetchCategories(completion: @escaping ([String]?) -> Void) {
        // Assuming you have an endpoint in your API to fetch categories
        guard let url = URL(string: "\(baseURL)/categories") else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            let categories = try? JSONDecoder().decode([String].self, from: data)
            DispatchQueue.main.async {
                completion(categories)
            }
        }.resume()
    }
    
    
    
    
    
    // Fetch product variants for a given product ID
    func fetchProductVariants(forProductId productId: Int, completion: @escaping ([ProductVariant]?) -> Void) {
        let endpoint = "/productVariants/\(productId)"
        guard let url = URL(string: baseURL + endpoint) else {
            print("Invalid URL")
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching product variants: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }
            
            do {
                let variants = try JSONDecoder().decode([ProductVariant].self, from: data)
                DispatchQueue.main.async {
                    completion(variants)
                }
            } catch {
                print("Failed to decode product variants: \(error)")
                completion(nil)
            }
        }
        task.resume()
    }
    
    
    
    
    func fetchSubCategories(forCategory category: String, completion: @escaping ([String]?) -> Void) {
        let endpoint = "/subcategories/\(category)"
        guard let url = URL(string: baseURL + endpoint) else {
            print("Invalid URL")
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching subcategories: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }
            
            do {
                let subcategories = try JSONDecoder().decode([String].self, from: data)
                DispatchQueue.main.async {
                    completion(subcategories)
                }
            } catch {
                print("Failed to decode subcategories: \(error)")
                completion(nil)
            }
        }
        task.resume()
    }
}

