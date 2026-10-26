import Foundation

final class ElectricityBill: Bill {

    // Pricing
    static let ratePerKWh: Double = 2_500   // VND / kWh

    // Properties
    private var consumptionKWh: Double

    // Constructors
    init(id: String,
         customerName: String,
         customerAddress: String,
         billingMonth: Int,
         billingYear: Int,
         consumptionKWh: Double) {
        self.consumptionKWh = consumptionKWh
        super.init(id: id,
                   customerName: customerName,
                   customerAddress: customerAddress,
                   billingMonth: billingMonth,
                   billingYear: billingYear)
    }

    // Getters / Setters
    func getConsumptionKWh() -> Double { consumptionKWh }
    func setConsumptionKWh(_ v: Double) { consumptionKWh = v }

    // Overrides
    override func serviceCategory() -> ServiceCategory { .electricity }

    override func calculateTotal() -> Double {
        consumptionKWh * Self.ratePerKWh
    }

    override func usageDescription() -> String {
        String(format: "Usage   : %.2f kWh × %@ VND/kWh",
               consumptionKWh,
               Bill.formatVND(Self.ratePerKWh))
    }
}
