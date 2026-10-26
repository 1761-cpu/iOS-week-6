import Foundation

class BillManager {
    // MARK: - Data
    private var bills: [Bill] = []

    // MARK: - Thêm / xoá
    func addBill(_ bill: Bill) {
        bills.append(bill)
    }

    func removeBill(byID id: String) {
        bills.removeAll { $0.getID() == id }
    }

    // MARK: - Lấy dữ liệu
    func getAllBills() -> [Bill] {
        return bills
    }

    func findBill(byID id: String) -> Bill? {
        for b in bills {
            if b.getID() == id { return b }
        }
        return nil
    }

    // MARK: - Thống kê — minh hoạ POLYMORPHISM
    // Không cần biết bill là Điện/Nước/Internet, gọi calculateBill() là đủ
    func totalRevenue() -> Double {
        var total = 0.0
        for b in bills {
            total += b.calculateBill(month: b.getMonth(), year: b.getYear())
        }
        return total
    }

    func countElectricity() -> Int {
        return bills.filter { $0 is ElectricityBill }.count
    }
    func countWater() -> Int {
        return bills.filter { $0 is WaterBill }.count
    }
    func countInternet() -> Int {
        return bills.filter { $0 is InternetBill }.count
    }
}
