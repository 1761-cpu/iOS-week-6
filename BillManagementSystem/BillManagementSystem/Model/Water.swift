import Foundation

final class WaterBill: Bill {

    // Pricing
    static let ratePerM3: Double = 10_000   // VND / m³

    // Properties
    private var consumptionM3: Double

    // Constructors
    init(id: String,
         customerName: String,
         customerAddress: String,
         billingMonth: Int,
         billingYear: Int,
         consumptionM3: Double) {
        self.consumptionM3 = consumptionM3
        super.init(id: id,
                   customerName: customerName,
                   customerAddress: customerAddress,
                   billingMonth: billingMonth,
                   billingYear: billingYear)
    }

    // Getters / Setters
    func getConsumptionM3() -> Double { consumptionM3 }
    func setConsumptionM3(_ v: Double) { consumptionM3 = v }

    // Overrides
    override func serviceCategory() -> ServiceCategory { .water }

    override func calculateTotal() -> Double {
        consumptionM3 * Self.ratePerM3
    }

    override func usageDescription() -> String {
        String(format: "Usage   : %.2f m³ × %@ VND/m³",
               consumptionM3,
               Bill.formatVND(Self.ratePerM3))
    }
}
