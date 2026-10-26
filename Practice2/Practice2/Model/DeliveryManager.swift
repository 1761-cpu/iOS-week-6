import Foundation
import Combine

class DeliveryManager: ObservableObject {
    @Published var orders: [DeliveryOrder] = []
    
    // MARK: - Thêm / Xoá
    func addOrder(_ order: DeliveryOrder) {
        orders.append(order)
    }
    
    func getAllOrders() -> [DeliveryOrder] {
        return orders
    }
    
    // MARK: - Xác nhận thanh toán
    func togglePaid(for order: DeliveryOrder) {
        let currentStatus = order.isPaid()
        order.setPaid(!currentStatus)
        
        objectWillChange.send()
    }
    
    // MARK: - Thống kê
    func totalRevenue() -> Double {
        return orders.reduce(0) { $0 + $1.calculateFee() }
    }

    // Đếm số lượng từng loại dịch vụ
    func countStandard() -> Int { return orders.filter { $0 is StandardDelivery }.count }
    func countExpress() -> Int { return orders.filter { $0 is ExpressDelivery }.count }
    func countSameDay() -> Int { return orders.filter { $0 is SameDayDelivery }.count }
}
