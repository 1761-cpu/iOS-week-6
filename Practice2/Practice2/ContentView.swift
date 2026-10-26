import SwiftUI

struct ContentView: View {
    @StateObject private var manager = DeliveryManager()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Tổng phí ship: \(Int(manager.totalRevenue())) VND")
                    .font(.title2).bold().foregroundColor(.orange).padding()
                
                List {
                    ForEach(manager.orders) { order in
                        VStack(alignment: .leading, spacing: 8) {
                            Text(order.getName()).font(.headline)
                            Text("Mã ĐH: \(order.getID())").font(.subheadline).foregroundColor(.gray)
                            
                            HStack {
                                if order is StandardDelivery {
                                    Text("Standard").foregroundColor(.gray)
                                } else if order is ExpressDelivery {
                                    Text("Express").foregroundColor(.blue)
                                } else if order is SameDayDelivery {
                                    Text("Same-Day").foregroundColor(.red)
                                }
                                
                                Spacer()
                                Text("\(Int(order.calculateFee())) VND")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.red)
                            }
                            
                            Divider()
                            
                            // TRẠNG THÁI THANH TOÁN
                            HStack {
                                if order.isPaid() {
                                    Label("Đã thanh toán", systemImage: "checkmark.circle.fill")
                                        .foregroundColor(.green).font(.caption)
                                } else {
                                    Label("Chưa thanh toán", systemImage: "xmark.circle.fill")
                                        .foregroundColor(.red).font(.caption)
                                }
                                
                                Spacer()
                                
                                Button(action: {
                                    manager.togglePaid(for: order)
                                }) {
                                    Text(order.isPaid() ? "Hoàn tác" : "Xác nhận")
                                        .font(.caption).bold()
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 5)
                                        .background(order.isPaid() ? Color.gray.opacity(0.2) : Color.orange)
                                        .foregroundColor(order.isPaid() ? .gray : .white)
                                        .cornerRadius(8)
                                }
                                .buttonStyle(.borderless)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle("Quản Lý Giao Hàng")
            .toolbar {
                Menu("Thêm Đơn") {
                    Button("Standard") { manager.addOrder(StandardDelivery(id: "ORD\(manager.orders.count+1)", name: "Khách A", address: "HCM", orderValue: 100000)) }
                    Button("Express") { manager.addOrder(ExpressDelivery(id: "ORD\(manager.orders.count+1)", name: "Khách B", address: "HN", orderValue: 200000)) }
                    Button("Same-Day") { manager.addOrder(SameDayDelivery(id: "ORD\(manager.orders.count+1)", name: "Khách C", address: "ĐN", orderValue: 300000)) }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
