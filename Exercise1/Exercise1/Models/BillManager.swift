import Foundation
import Combine

class BillManager: ObservableObject {
    // MARK: - Data
    @Published var bills: [Bill] = []

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

    func togglePaid(for bill: Bill) {
        if let eBill = bill as? ElectricityBill {
            eBill.setPaid(!eBill.isPaid())
        } else if let wBill = bill as? WaterBill {
            wBill.setPaid(!wBill.isPaid())
        } else if let iBill = bill as? InternetBill {
            iBill.setPaid(!iBill.isPaid())
        }
        objectWillChange.send() // Ép UI vẽ lại
    }
    
    func totalRevenue() -> Double {
        return bills.reduce(0) { $0 + $1.calculateBill(month: $1.getMonth(), year: $1.getYear()) }
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
