import Foundation

class ElectricityBill: Bill {
    // MARK: - Properties
    private var amount: Int       // kWh
    private var unitprice: Int    // VND/kWh
    private var paid: Bool

    // MARK: - Constructors
    override init() {
        self.amount = 0
        self.unitprice = 2500
        self.paid = false
        super.init()
    }

    init(id: String, name: String, address: String,
         month: Int, year: Int, amount: Int) {
        self.amount = amount
        self.unitprice = 2500
        self.paid = false
        super.init(id: id, name: name, address: address, month: month, year: year)
    }

    // MARK: - Getters
    func getAmount() -> Int    { return amount }
    func getUnitPrice() -> Int { return unitprice }
    func isPaid() -> Bool      { return paid }

    // MARK: - Setters
    func setAmount(_ a: Int) { amount = a }
    func setPaid(_ b: Bool)  { paid = b }

    // MARK: - Override 
    override func calculateBill(month: Int, year: Int) -> Double {
        return Double(amount * unitprice)
    }

    // MARK: - Display
    override func displayInfo() {
        print("[Electricity] \(getID()) – \(getName()) – \(getMonth())/\(getYear())")
        print("  \(amount) kWh × \(unitprice) = \(calculateBill(month: getMonth(), year: getYear())) VND")
        print("  Paid: \(paid)")
    }
}
