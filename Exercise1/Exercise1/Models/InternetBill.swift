import Foundation

class InternetBill: Bill {
    private var unitprice: Int    // 200000 VND cố định
    private var paid: Bool

    override init() {
        self.unitprice = 200000
        self.paid = false
        super.init()
    }

    override init(id: String, name: String, address: String, month: Int, year: Int) {
        self.unitprice = 200000
        self.paid = false
        super.init(id: id, name: name, address: address, month: month, year: year)
    }
    
    func getUnitPrice() -> Int { return unitprice }
    func isPaid() -> Bool      { return paid }
    func setPaid(_ b: Bool)    { paid = b }

    // Internet không quan tâm month/year → luôn trả phí cố định
    override func calculateBill(month: Int, year: Int) -> Double {
        return Double(unitprice)
    }

    override func displayInfo() {
        print("[Internet] \(getID()) – \(getName()) – \(getMonth())/\(getYear())")
        print("  Fixed package = \(unitprice) VND")
        print("  Paid: \(paid)")
    }
}
