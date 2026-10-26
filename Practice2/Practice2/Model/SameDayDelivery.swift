import Foundation

class SameDayDelivery: DeliveryOrder {
    // Phí cố định 60,000 VND
    override func calculateFee() -> Double {
        return 60000.0
    }
    
    override func getDeliveryTime() -> String {
        return "Same Day"
    }
}