import Foundation
import Combine

final class BillManager: ObservableObject {

    // MARK: - Data
    @Published private(set) var bills: [Bill] = []

    // MARK: - Init
    init(sample: Bool = false) {
        if sample { loadSampleData() }
    }

    // MARK: - 1. LOOKUP
    func bill(withID id: String) -> Bill? {
        bills.first { $0.getID() == id }
    }

    func bills(byCategory category: ServiceCategory) -> [Bill] {
        bills.filter { $0.serviceCategory() == category }
    }

    func bills(inMonth month: Int, year: Int) -> [Bill] {
        bills.filter { $0.getBillingMonth() == month && $0.getBillingYear() == year }
    }

    // MARK: - 2. VALIDATION (dùng chung cho mọi lớp con)
    private func validateCommon(id: String,
                                name: String,
                                address: String,
                                month: Int,
                                year: Int) throws {
        let cleanID = id.trimmingCharacters(in: .whitespaces)
        guard !cleanID.isEmpty else { throw BillError.emptyField("Bill ID") }
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty else {
            throw BillError.emptyField("Customer Name")
        }
        guard !address.trimmingCharacters(in: .whitespaces).isEmpty else {
            throw BillError.emptyField("Customer Address")
        }
        guard (1...12).contains(month) else { throw BillError.invalidMonth(month) }
        guard year > 2000 else { throw BillError.invalidYear(year) }
        guard bill(withID: cleanID) == nil else { throw BillError.duplicateBill(cleanID) }
    }

    // MARK: - 3. ADD METHODS (mỗi dịch vụ 1 hàm)

    func addElectricityBill(id: String,
                            customerName: String,
                            customerAddress: String,
                            billingMonth: Int,
                            billingYear: Int,
                            consumptionKWh: Double) throws {
        try validateCommon(id: id, name: customerName, address: customerAddress,
                           month: billingMonth, year: billingYear)
        guard consumptionKWh >= 0 else {
            throw BillError.invalidConsumption("Electricity", consumptionKWh)
        }
        bills.append(ElectricityBill(id: id,
                                     customerName: customerName,
                                     customerAddress: customerAddress,
                                     billingMonth: billingMonth,
                                     billingYear: billingYear,
                                     consumptionKWh: consumptionKWh))
    }

    func addWaterBill(id: String,
                      customerName: String,
                      customerAddress: String,
                      billingMonth: Int,
                      billingYear: Int,
                      consumptionM3: Double) throws {
        try validateCommon(id: id, name: customerName, address: customerAddress,
                           month: billingMonth, year: billingYear)
        guard consumptionM3 >= 0 else {
            throw BillError.invalidConsumption("Water", consumptionM3)
        }
        bills.append(WaterBill(id: id,
                               customerName: customerName,
                               customerAddress: customerAddress,
                               billingMonth: billingMonth,
                               billingYear: billingYear,
                               consumptionM3: consumptionM3))
    }

    func addInternetBill(id: String,
                         customerName: String,
                         customerAddress: String,
                         billingMonth: Int,
                         billingYear: Int) throws {
        try validateCommon(id: id, name: customerName, address: customerAddress,
                           month: billingMonth, year: billingYear)
        bills.append(InternetBill(id: id,
                                  customerName: customerName,
                                  customerAddress: customerAddress,
                                  billingMonth: billingMonth,
                                  billingYear: billingYear))
    }

    // MARK: - 4. UPDATE / REMOVE
    func updateElectricityConsumption(billID: String, newKWh: Double) throws {
        guard let b = bill(withID: billID) as? ElectricityBill else {
            throw BillError.billNotFound(billID)
        }
        guard newKWh >= 0 else {
            throw BillError.invalidConsumption("Electricity", newKWh)
        }
        b.setConsumptionKWh(newKWh)
        objectWillChange.send()
    }

    func updateWaterConsumption(billID: String, newM3: Double) throws {
        guard let b = bill(withID: billID) as? WaterBill else {
            throw BillError.billNotFound(billID)
        }
        guard newM3 >= 0 else {
            throw BillError.invalidConsumption("Water", newM3)
        }
        b.setConsumptionM3(newM3)
        objectWillChange.send()
    }

    func removeBill(id: String) {
        bills.removeAll { $0.getID() == id }
    }

    // MARK: - 5. STATISTICS
    /// Tổng doanh thu toàn bộ hóa đơn. KHÔNG cần biết loại cụ thể → minh hoạ polymorphism.
    func totalRevenue() -> Double {
        bills.reduce(0) { $0 + $1.calculateTotal() }
    }

    /// Doanh thu theo từng loại dịch vụ.
    func revenueByCategory() -> [ServiceCategory: Double] {
        var result: [ServiceCategory: Double] = [:]
        for b in bills {
            result[b.serviceCategory(), default: 0] += b.calculateTotal()
        }
        return result
    }

    /// Tổng hợp doanh thu theo tháng (gồm số hóa đơn + tổng tiền).
    func monthlySummary(month: Int, year: Int)
        -> [ServiceCategory: (count: Int, total: Double)] {
        var result: [ServiceCategory: (count: Int, total: Double)] = [:]
        for b in bills(inMonth: month, year: year) {
            let c = b.serviceCategory()
            let cur = result[c] ?? (0, 0)
            result[c] = (cur.count + 1, cur.total + b.calculateTotal())
        }
        return result
    }

    /// Top khách hàng trả nhiều nhất (gộp tất cả hóa đơn theo tên KH).
    func topCustomers(limit: Int = 5) -> [(customer: String, total: Double)] {
        var map: [String: Double] = [:]
        for b in bills {
            map[b.getCustomerName(), default: 0] += b.calculateTotal()
        }
        return map.sorted { $0.value > $1.value }
            .prefix(limit)
            .map { (customer: $0.key, total: $0.value) }
    }

    /// Hoá đơn trung bình.
    func averageBill() -> Double? {
        bills.isEmpty ? nil : totalRevenue() / Double(bills.count)
    }

    // MARK: - 6. SAMPLE DATA
    private func loadSampleData() {
        _ = try? addElectricityBill(id: "E001",
                                    customerName: "Nguyễn Ánh",
                                    customerAddress: "HCM",
                                    billingMonth: 10, billingYear: 2025,
                                    consumptionKWh: 150)
        _ = try? addElectricityBill(id: "E002",
                                    customerName: "Phạm Bảo",
                                    customerAddress: "Hà Nội",
                                    billingMonth: 10, billingYear: 2025,
                                    consumptionKWh: 220)

        _ = try? addWaterBill(id: "W001",
                              customerName: "Nguyễn Ánh",
                              customerAddress: "HCM",
                              billingMonth: 10, billingYear: 2025,
                              consumptionM3: 12)
        _ = try? addWaterBill(id: "W002",
                              customerName: "Trần Đông",
                              customerAddress: "Đà Nẵng",
                              billingMonth: 10, billingYear: 2025,
                              consumptionM3: 8.5)

        _ = try? addInternetBill(id: "I001",
                                 customerName: "Nguyễn Ánh",
                                 customerAddress: "HCM",
                                 billingMonth: 10, billingYear: 2025)
        _ = try? addInternetBill(id: "I002",
                                 customerName: "Hạ Cẩm",
                                 customerAddress: "Huế",
                                 billingMonth: 10, billingYear: 2025)
    }
}

extension BillManager {
    static func preview() -> BillManager { BillManager(sample: true) }
}
