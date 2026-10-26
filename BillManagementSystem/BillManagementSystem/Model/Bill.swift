import Foundation

// MARK: - Service Category
/// Liệt kê các loại dịch vụ hiện có.
/// Khi thêm dịch vụ mới (vd: Gas), chỉ cần thêm 1 case ở đây.
enum ServiceCategory: String, CaseIterable, Identifiable {
    case electricity = "Electricity"
    case water       = "Water"
    case internet    = "Internet"
    case gas         = "Gas"
    
    var id: String { rawValue }
}

// MARK: - Bill (BASE CLASS)
/// Lớp cơ sở chứa toàn bộ thông tin chung của mọi hóa đơn.
/// - Encapsulation: các field đều `private`, chỉ truy cập qua getter/setter.
/// - Inheritance: các lớp con kế thừa và override `calculateTotal()` / `serviceCategory()`.
class Bill: Identifiable {

    // MARK: - Properties (Encapsulation)
    var id: String                       // billID - dùng làm Identifiable
    private var customerName: String
    private var customerAddress: String
    private var billingMonth: Int        // 1...12
    private var billingYear: Int

    // MARK: - Constructors
    init() {
        self.id              = ""
        self.customerName    = ""
        self.customerAddress = ""
        self.billingMonth    = 1
        self.billingYear     = 2025
    }

    init(id: String,
         customerName: String,
         customerAddress: String,
         billingMonth: Int,
         billingYear: Int) {
        self.id              = id
        self.customerName    = customerName
        self.customerAddress = customerAddress
        self.billingMonth    = billingMonth
        self.billingYear     = billingYear
    }

    // MARK: - Getters
    func getID() -> String              { id }
    func getCustomerName() -> String    { customerName }
    func getCustomerAddress() -> String { customerAddress }
    func getBillingMonth() -> Int       { billingMonth }
    func getBillingYear() -> Int        { billingYear }

    // MARK: - Setters
    func setID(_ newID: String)               { id = newID }
    func setCustomerName(_ newName: String)   { customerName = newName }
    func setCustomerAddress(_ newAddr: String) { customerAddress = newAddr }
    func setBillingMonth(_ newMonth: Int)     { billingMonth = newMonth }
    func setBillingYear(_ newYear: Int)       { billingYear = newYear }

    // MARK: - Abstract methods (BẮT BUỘC override ở lớp con)
    /// Loại dịch vụ của hóa đơn — quyết định công thức tính tiền.
    func serviceCategory() -> ServiceCategory {
        fatalError("Subclass of Bill must override serviceCategory()")
    }

    /// Tổng tiền phải trả (VND). Lớp con override theo công thức riêng.
    func calculateTotal() -> Double {
        fatalError("Subclass of Bill must override calculateTotal()")
    }

    /// Chuỗi mô tả chi tiết cách tính (kWh, m³, gói cước…). Mặc định rỗng.
    func usageDescription() -> String { "" }

    // MARK: - Display
    func displayInfo() {
        let totalStr = Bill.formatVND(calculateTotal())
        print("""
        ─────────────────────────────────────────────
         Bill ID : \(id)
         Service : \(serviceCategory().rawValue)
         Customer: \(customerName)
         Address : \(customerAddress)
         Period  : \(String(format: "%02d", billingMonth))/\(billingYear)
         \(usageDescription())
         TOTAL   : \(totalStr) VND
        ─────────────────────────────────────────────
        """)
    }

    // MARK: - Helpers
    /// Format số tiền VND cho đẹp (vd: 1,250,000)
    nonisolated static func formatVND(_ amount: Double) -> String {
        let f = NumberFormatter()
        f.numberStyle = .decimal
        f.groupingSeparator = ","
        f.maximumFractionDigits = 0
        return f.string(from: NSNumber(value: amount)) ?? "\(Int(amount))"
    }
}
