import Foundation

@MainActor
func runLogicTest() {
    print("\n==================================")
    print("🚀 BẮT ĐẦU CHẠY TEST LOGIC")
    print("==================================")
    
    // 1. Tạo manager và nạp dữ liệu mẫu
    let manager = BillManager(sample: true)
    
    // 2. In tất cả hóa đơn (minh hoạ POLYMORPHISM)
    print("\n=== DANH SÁCH HOÁ ĐƠN ===\n")
    for b in manager.bills {
        b.displayInfo()
    }
    
    // 3. Thống kê
    print("\n=== THỐNG KÊ ===")
    print("Tổng doanh thu: \(Bill.formatVND(manager.totalRevenue())) VND")
    print("Hoá đơn trung bình: \(manager.averageBill().map(Bill.formatVND) ?? "-") VND")
    
    print("\nDoanh thu theo loại:")
    for c in ServiceCategory.allCases {
        let r = manager.revenueByCategory()[c] ?? 0
        print(" - \(c.rawValue): \(Bill.formatVND(r)) VND")
    }
    
    print("\nTop khách hàng:")
    for (i, item) in manager.topCustomers(limit: 3).enumerated() {
        print(" \(i+1). \(item.customer) — \(Bill.formatVND(item.total)) VND")
    }
    
    print("\n==================================")
    print("✅ KẾT THÚC TEST")
    print("==================================\n")
}
