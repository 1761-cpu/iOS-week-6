import Foundation

final class InternetBill: Bill {

    // Pricing (chỉ có 1 gói cước cố định)
    static let monthlyFee: Double = 200_000   // VND / tháng

    // Overrides
    override func serviceCategory() -> ServiceCategory { .internet }

    override func calculateTotal() -> Double { Self.monthlyFee }

    override func usageDescription() -> String {
        "Package : Fixed monthly subscription (\(Bill.formatVND(Self.monthlyFee)) VND)"
    }
}
