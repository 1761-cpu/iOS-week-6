import Foundation

enum BillError: LocalizedError {
    case emptyField(String)
    case duplicateBill(String)
    case billNotFound(String)
    case invalidMonth(Int)
    case invalidYear(Int)
    case invalidConsumption(String, Double)

    var errorDescription: String? {
        switch self {
        case .emptyField(let f):
            return "\(f) cannot be empty."
        case .duplicateBill(let id):
            return "Bill ID \(id) already exists."
        case .billNotFound(let id):
            return "Bill with ID \(id) not found."
        case .invalidMonth(let m):
            return "Month \(m) must be between 1 and 12."
        case .invalidYear(let y):
            return "Year \(y) must be greater than 2000."
        case .invalidConsumption(let kind, let v):
            return "\(kind) consumption \(v) must be >= 0."
        }
    }
}
