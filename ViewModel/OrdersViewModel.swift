//
//  OrdersViewModel.swift
//  SingheClothing
//
//  Created by Dasun Pamuditha on 2024-03-31.
//

import Foundation
// Modify your OrdersViewModel.swift
class OrdersViewModel: ObservableObject {
    @Published var orders: [Order] = []
    private var apiService = ApiService()
    private var userId: Int

    init(userId: Int) {
        self.userId = userId
    }

    func loadOrders() {
        apiService.fetchOrders(forUserId: userId) { [weak self] fetchedOrders in
            self?.orders = fetchedOrders ?? []
        }
    }
}
