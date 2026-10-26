import Foundation

class ExpressDelivery: DeliveryOrder {
    // Fixed fee 40,000 VND
    override func calculateFee() -> Double {
        return 40000.0
    }
    
    override func getDeliveryTime() -> String {
        return "1 - 2 days"
    }
}
