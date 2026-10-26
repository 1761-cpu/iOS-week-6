import Foundation

class DeliveryManager {
    private var orders: [DeliveryOrder] = []
    
    // MARK: - Thêm / Xoá
    func addOrder(_ order: DeliveryOrder) {
        orders.append(order)
    }
    
    func getAllOrders() -> [DeliveryOrder] {
        return orders
    }
    
    // MARK: - Thống kê
    // Tính tổng phí giao hàng của tất cả đơn
    func totalRevenue() -> Double {
        var total = 0.0
        for order in orders {
            total += order.calculateFee()
        }
        return total
    }
    
    // Đếm số lượng từng loại dịch vụ
    func countStandard() -> Int { return orders.filter { $0 is StandardDelivery }.count }
    func countExpress() -> Int { return orders.filter { $0 is ExpressDelivery }.count }
    func countSameDay() -> Int { return orders.filter { $0 is SameDayDelivery }.count }
}