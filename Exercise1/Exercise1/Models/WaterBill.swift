import Foundation

class WaterBill: Bill {
    private var amount: Int       // số m³
    private var unitprice: Int    // 10000 VND/m³
    private var paid: Bool

    override init() {
        self.amount = 0
        self.unitprice = 10000
        self.paid = false
        super.init()
    }

    init(id: String, name: String, address: String,
         month: Int, year: Int, amount: Int) {
        self.amount = amount
        self.unitprice = 10000
        self.paid = false
        super.init(id: id, name: name, address: address, month: month, year: year)
    }

    func getAmount() -> Int    { return amount }
    func getUnitPrice() -> Int { return unitprice }
    func isPaid() -> Bool      { return paid }

    func setAmount(_ a: Int) { amount = a }
    func setPaid(_ b: Bool)  { paid = b }

    override func calculateBill(month: Int, year: Int) -> Double {
        return Double(amount * unitprice)
    }

    override func displayInfo() {
        print("[Water] \(getID()) – \(getName()) – \(getMonth())/\(getYear())")
        print("  \(amount) m³ × \(unitprice) = \(calculateBill(month: getMonth(), year: getYear())) VND")
        print("  Paid: \(paid)")
    }
}
