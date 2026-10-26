import Foundation

class DeliveryOrder: Identifiable {
    var id: String // Dùng làm orderID
    private var customerName: String
    private var deliveryAddress: String
    private var orderValue: Double
    
    // MARK: - Constructors
    init() {
        self.id = ""
        self.customerName = ""
        self.deliveryAddress = ""
        self.orderValue = 0.0
    }
    
    init(id: String, name: String, address: String, orderValue: Double) {
        self.id = id
        self.customerName = name
        self.deliveryAddress = address
        self.orderValue = orderValue
    }
    
    // MARK: - Getters
    func getID() -> String { return id }
    func getName() -> String { return customerName }
    func getAddress() -> String { return deliveryAddress }
    func getOrderValue() -> Double { return orderValue }
    
    // MARK: - Setters
    func setID(_ newID: String) { self.id = newID }
    func setName(_ newName: String) { self.customerName = newName }
    func setAddress(_ newAddress: String) { self.deliveryAddress = newAddress }
    func setOrderValue(_ newValue: Double) { self.orderValue = newValue }
    
    // MARK: - Methods (Lớp con sẽ override)
    // Phí giao hàng mặc định là 0
    func calculateFee() -> Double {
        return 0.0
    }
    
    // Thời gian giao hàng mặc định
    func getDeliveryTime() -> String {
        return "Unknown"
    }
    
    // MARK: - Display
    func displayInfo() {
        print("[\(id)] \(customerName) - \(deliveryAddress)")
        print("  Order Value: \(orderValue) VND")
        print("  Delivery Time: \(getDeliveryTime())")
        print("  Shipping Fee: \(calculateFee()) VND")
    }
}