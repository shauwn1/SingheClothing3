//import SwiftUI
//
//struct OrdersView: View {
//    @ObservedObject var viewModel: OrdersViewModel
//
//    var body: some View {
//        List {
//            ForEach(viewModel.orders) { order in
//                VStack(alignment: .leading) {
//                    Text("Order ID: \(order.id)")
//                    Text("Ordered Date: \(order.date.formatted())")
//                    ForEach(order.items, id: \.id) { item in
//                        HStack {
//                            AsyncImage(url: URL(string: item.image)) { imagePhase in
//                                if let image = imagePhase.image {
//                                    image.resizable().aspectRatio(contentMode: .fit)
//                                } else if imagePhase.error != nil {
//                                    Color.red // Indicates an error.
//                                } else {
//                                    ProgressView() // Shows a loading indicator.
//                                }
//                            }
//                            .frame(width: 50, height: 50)
//                            .cornerRadius(5)
//
//                            VStack(alignment: .leading) {
//                                Text(item.title)
//                                Text("Quantity: \(item.quantity)")
//                                // Include other details like price, size, color if needed
//                            }
//                        }
//                    }
//                }
//            }
//        }
//        .onAppear {
//            viewModel.loadOrders()
//        }
//    }
//}
