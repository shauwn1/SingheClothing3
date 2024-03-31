//
//  APIServiceModel.swift
//  SingheClothing
//
//  Created by Shehara Jayasooriya on 2024-03-24.
//

import Foundation
class ApiService {
    private let baseURL = "http://localhost:3000/api"
    
    func fetchProducts(forCategory category: String, subCategory: String? = nil, completion: @escaping ([ClothingItem]?) -> Void) {
        let formattedCategory = category.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        var urlString = "\(baseURL)/products/\(formattedCategory)"
        
        if let subCategory = subCategory {
            let formattedSubCategory = subCategory.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            urlString += "/\(formattedSubCategory)"
            print (formattedSubCategory)
        }
        
        guard let url = URL(string: urlString) else {
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
    
    
    func fetchAllProducts(completion: @escaping ([ClothingItem]?) -> Void) {
        let urlString = "\(baseURL)/products" // Adjust the endpoint as needed for your API

        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                completion(nil)
            }
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching all products: \(error)")
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }

            guard let data = data else {
                print("No data received for all products")
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
                print("Failed to decode all products: \(error)")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }.resume()
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
    
    
    
    

        func fetchUserProfile(userId: Int, completion: @escaping (User?) -> Void) {
            let url = URL(string: "\(baseURL)/users/\(userId)")!
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                    return
                }
                let user = try? JSONDecoder().decode(User.self, from: data)
                DispatchQueue.main.async {
                    completion(user)
                }
            }.resume()
        }

        func updateUserProfile(userId: Int, updatedUser: User, completion: @escaping (Bool) -> Void) {
            let url = URL(string: "\(baseURL)/users/\(userId)")!
            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try? JSONEncoder().encode(updatedUser)
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    DispatchQueue.main.async {
                        completion(false)
                    }
                    return
                }
                DispatchQueue.main.async {
                    completion(true)
                }
            }.resume()
        
    }
    func fetchOrders(forUserId userId: Int, completion: @escaping ([Order]?) -> Void) {
        let urlString = "\(baseURL)/users/\(userId)/orders"
        guard let url = URL(string: urlString) else { return completion(nil) }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching orders: \(error)")
                return completion(nil)
            }
            guard let data = data else {
                print("No data received for orders")
                return completion(nil)
            }
            do {
                let orders = try JSONDecoder().decode([Order].self, from: data)
                DispatchQueue.main.async {
                    completion(orders)
                }
            } catch {
                print("Failed to decode orders: \(error)")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }.resume()
    }
    
    
    func placeOrder(userID: Int, items: [CartItem], completion: @escaping (Bool) -> Void) {
            let urlString = "\(baseURL)/orders"
            guard let url = URL(string: urlString) else {
                completion(false)
                return
            }

        let orderItems = items.map { OrderItem(productId: $0.product.id, size: $0.size, color: $0.color, quantity: $0.quantity) }
            let orderDetails = OrderDetails(userId: userID, items: orderItems)
        print("Placing order for user ID: \(userID) with items: \(orderItems)")
            guard let jsonData = try? JSONEncoder().encode(orderDetails) else {
                completion(false)
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = jsonData
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")

            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    completion(false)
                    return
                }
                completion(true)
            }.resume()
        }
    
}

