import Foundation

class StandardDelivery: DeliveryOrder {
    // Fixed fee 20,000 VND
    override func calculateFee() -> Double {
        return 20000.0
    }
    
    override func getDeliveryTime() -> String {
        return "3 - 5 days"
    }
}
