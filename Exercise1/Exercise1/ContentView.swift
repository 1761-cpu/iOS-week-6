import SwiftUI

struct ContentView: View {
    @StateObject private var manager = BillManager()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Tổng doanh thu: \(Int(manager.totalRevenue())) VND")
                    .font(.title2).bold().foregroundColor(.blue).padding()
                
                List {
                    ForEach(manager.bills) { bill in
                        VStack(alignment: .leading, spacing: 8) {
                            
                            Text(bill.getName()).font(.headline)
                            Text("Mã HĐ: \(bill.getID())").font(.subheadline).foregroundColor(.gray)
                            
                            if let eBill = bill as? ElectricityBill {
                                Text("Điện: \(eBill.getAmount()) kWh")
                                    .foregroundColor(.orange).font(.system(size: 14, weight: .semibold))
                            } else if let wBill = bill as? WaterBill {
                                Text("Nước: \(wBill.getAmount()) m³")
                                    .foregroundColor(.blue).font(.system(size: 14, weight: .semibold))
                            } else if bill is InternetBill {
                                Text("Internet: Gói cố định")
                                    .foregroundColor(.purple).font(.system(size: 14, weight: .semibold))
                            }
                            
                            Text("Thành tiền: \(Int(bill.calculateBill(month: bill.getMonth(), year: bill.getYear()))) VND")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.green)
                            
                            Divider()
                            
                            // TRẠNG THÁI THANH TOÁN
                            HStack {
                                let isPaid: Bool = {
                                    if let e = bill as? ElectricityBill { return e.isPaid() }
                                    if let w = bill as? WaterBill { return w.isPaid() }
                                    if let i = bill as? InternetBill { return i.isPaid() }
                                    return false
                                }()
                                
                                if isPaid {
                                    Label("Đã thanh toán", systemImage: "checkmark.circle.fill")
                                        .foregroundColor(.green).font(.caption)
                                } else {
                                    Label("Chưa thanh toán", systemImage: "xmark.circle.fill")
                                        .foregroundColor(.red).font(.caption)
                                }
                                
                                Spacer()
                                
                                Button(action: {
                                    manager.togglePaid(for: bill)
                                }) {
                                    Text(isPaid ? "Hoàn tác" : "Xác nhận")
                                        .font(.caption).bold()
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 5)
                                        .background(isPaid ? Color.gray.opacity(0.2) : Color.blue)
                                        .foregroundColor(isPaid ? .gray : .white)
                                        .cornerRadius(8)
                                }
                                .buttonStyle(.borderless)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle("Quản Lý Hoá Đơn")
            .toolbar {
                Button("Thêm Mẫu") {
                    let eBill = ElectricityBill(id: "E\(manager.bills.count+1)", name: "Khách \(manager.bills.count+1)", address: "HCM", month: 10, year: 2025, amount: 150)
                    let wBill = WaterBill(id: "W\(manager.bills.count+1)", name: "Khách \(manager.bills.count+1)", address: "HN", month: 10, year: 2025, amount: 10)
                    manager.addBill(eBill)
                    manager.addBill(wBill)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
