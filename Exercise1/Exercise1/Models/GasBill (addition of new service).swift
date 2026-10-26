import Foundation

class GasBill: Bill {
    private var amount: Int
    private var unitprice: Int = 45000
    private var paid: Bool = false

    init(id: String, name: String, address: String,
         month: Int, year: Int, amount: Int) {
        self.amount = amount
        super.init(id: id, name: name, address: address, month: month, year: year)
    }

    override func calculateBill(month: Int, year: Int) -> Double {
        return Double(amount * unitprice)
    }
}
