import Foundation

// Class cha chứa mọi thông tin chung
class Bill: Identifiable {
    var id: String                    // internal → Identifiable dùng được
    private var customerName: String
    private var customerAddress: String
    private var month: Int
    private var year: Int

    // MARK: - Constructors
    init() {
        self.id = ""
        self.customerName = ""
        self.customerAddress = ""
        self.month = 1
        self.year = 2024
    }

    init(id: String, name: String, address: String, month: Int, year: Int) {
        self.id = id
        self.customerName = name
        self.customerAddress = address
        self.month = month
        self.year = year
    }

    // MARK: - Getters
    func getID() -> String      { return id }
    func getName() -> String    { return customerName }
    func getAddress() -> String { return customerAddress }
    func getMonth() -> Int      { return month }
    func getYear() -> Int       { return year }

    // MARK: - Setters
    func setID(_ x: String)       { id = x }
    func setName(_ x: String)     { customerName = x }
    func setAddress(_ x: String)  { customerAddress = x }
    func setMonth(_ m: Int)       { month = m }
    func setYear(_ y: Int)        { year = y }

    // MARK: - Calculate (children override)
    // Base trả về 0 — mỗi lớp con sẽ override theo công thức riêng
    func calculateBill(month: Int, year: Int) -> Double {
        return 0.0
    }

    // MARK: - Display
    func displayInfo() {
        print("[\(id)] \(customerName) – \(customerAddress) – \(month)/\(year)")
        print("  Total: \(calculateBill(month: month, year: year)) VND")
    }
}
