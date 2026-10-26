import Foundation

final class GasBill: Bill {
    private var consumptionKg: Double
    static let ratePerKg: Double = 45_000

    init(id: String,
         customerName: String,
         customerAddress: String,
         billingMonth: Int,
         billingYear: Int,
         consumptionKg: Double) {
        
        self.consumptionKg = consumptionKg
        
        super.init(id: id,
                   customerName: customerName,
                   customerAddress: customerAddress,
                   billingMonth: billingMonth,
                   billingYear: billingYear)
    }

    override func serviceCategory() -> ServiceCategory {
        return .gas
    }
    
    override func calculateTotal() -> Double {
        return consumptionKg * Self.ratePerKg
    }
    
    override func usageDescription() -> String {
        return String(format: "Usage   : %.2f kg × %@ VND/kg",
               consumptionKg,
               Bill.formatVND(Self.ratePerKg))
    }
}
