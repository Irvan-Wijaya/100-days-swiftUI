import Foundation

// MARK: - Overview
/// **Enumerations (enum)**
/// An enumeration defines a finite set of related values.  Instead of relying on arbitrary Strings or Integers, enums provide type-safe, self-documenting code.
/// From an engineering perspective, enums eliminate invalid states, improve code readability, and make applications easier to maintain.

// MARK: 1. Defining an Enumeration
enum Direction {
    case north
    case south
    case east
    case west
}

// MARK: 2. Creating Enum Values
let currentDirection = Direction.north

// Type inference allows the shorthand syntax.
let nextDirection: Direction = .east

// MARK: 3. Why Use Enums?
/// Avoid magic strings.
let status = "success"
//if status == "success" {}

/// A typo introduces a bug.
let typo = "succes"

/// Prefer enums.
enum RequestStatus {
    case success
    case failure
    case loading
}

let requestStatus = RequestStatus.success
// Impossible to write:
// RequestStatus.succes -> The compiler catches the mistake immediately.

// MARK: 4. Type Safety
/// Enum values belong only to their own type.

enum PaymentMethods {
    case cash
    case creditCard
}

enum DeliveryMethod {
    case pickup
    case shipping
}

let payment = PaymentMethods.cash

// Error
// payment = DeliveryMethod.pickup

// MARK: 5. Switching over Enums
/// Enums are designed to work with switch.
/*
switch payment {
case .cash:
    print("Cash")

case .creditCard:
    print("Credit Card")

}
*/

// MARK: 6. Exhaustiveness Checking
/// Swift requires every enum case to be handled.

enum TrafficLight {
    case red
    case yellow
    case green
}

let light = TrafficLight.red
/*
switch light {
case .red:
    print("Stop")

case .yellow:
    print("Prepare")

case .green:
    print("Go")

}
*/

/// If a new case is added:
/// case flashing -> The compiler forces every switch statement to be updated.
// This prevents forgotten business logic.

// MARK: 7. Value Type
/// Enumerations are value types. Assigning an enum copies the value.

let current = TrafficLight.red
//let copied = current

// MARK: 8. Best Practices
/// Group only related values together.

enum LoginState {
    case idle
    case loading
    case success
    case failure
}

/// Prefer descriptive singular names.
//enum Direction { }

/// Better than
enum Directions { }

/// ✖️ Avoid using Strings when the possible values are known(avoid magic strings).
let role = "Admin"

/// ✔️
enum UserRole {
    case admin
    case moderator
    case guest
}

// =================================================================================

// Associated Values
/// when login succeed, we need User data and when failed we need error message
struct User {
    let id: String
    let name: String
}

enum ViewState {
    case idle
    case loading
    case success(user: User)
    case failure(message: String)
}

// Implemantation in ViewModel / ViewController:
let currentState = ViewState.success(user: User(id: "1", name: "Budi"))

switch currentState {
case .idle:
    print("waiting user input...")
case .loading:
    print("show loading spinner")
case .success(let user):
    print("welcome, \(user.name)!")
case .failure(let message):
    print(" show alert error: \(message)")
}

// =================================================================================

/// `Codable` allows the enum to be automatically converted to and from other data formats, most notably JSON.
/// - The enum must have a defined `RawValue` (e.g., `String` or `Int`) so Swift knows how to map the data during encoding and decoding.
/// - It eliminates the need to write custom parsing logic when integrating with APIs or local storage.
enum OrderStatus: String, Codable {
    case pending = "PENDING_PAYMENT"
    case processing = "IN_PROCESS"
    case shipped = "SHIPPED"
}

// Example: Decoding/Converting a String from an API into an Enum instance
let apiResponse = "SHIPPED"
if let status = OrderStatus(rawValue: apiResponse) {
    print("Status: \(status)") // shipped
    print("Raw Value: \(status.rawValue)") // SHIPPED
}

// =================================================================================

/// `CaseIterable` automatically provides an `allCases` property that returns a collection of all enum cases.
/// - The enum itself does not become an array; you must access `.allCases` to get the collection.
/// - This enables the use of standard array/collection methods directly on `.allCases`.
enum AppTheme: String, CaseIterable {
    case system = "Sesuai Sistem"
    case light = "Mode Terang"
    case dark = "Mode Gelap"
}

// Example: Iterating through all cases using a loop
for theme in AppTheme.allCases {
    print(theme.rawValue)
}

/// You can then use standard Collection methods on `.allCases` just like an ordinary array.
/// - Common methods include `.count`, `.map()`, `.filter()`, `.randomElement()`, and `.shuffled()`.
let totalTheme = AppTheme.allCases.count
let modeTheme = AppTheme.allCases.map { "\(\$0)".capitalized }
let randomTheme = AppTheme.allCases.randomElement()

// =================================================================================

/// STUDY NOTES: NESTED ENUMS & ASSOCIATED VALUES
/// - Nested Enums (`Bank`, `EWalletProvider`) group related choices inside a parent namespace.
/// - Associated Values store dynamic, case-specific data (like `phoneNumber` or `lastFourDigits`).
/// - Value Binding (`let`) extracts this custom data inside the `switch` statement for runtime use.

enum PaymentMethod {
    // 1. Nested Enum for Bank category
    enum Bank: String, CaseIterable {
        case bca = "BCA Virtual Account"
        case mandiri = "Mandiri Bill"
        case bni = "BNI Virtual Account"
    }

    // 2. Nested Enum for E-Wallet category
    enum EWalletProvider: String, CaseIterable {
        case gopay = "GoPay"
        case octo = "Octo Pay"
        case ovo = "OVO"
        case dana = "DANA"
    }

    // Main cases using Nested Enums and custom data as Associated Values
    case cashOnDelivery
    case bankTransfer(Bank)
    case eWallet(EWalletProvider, phoneNumber: String)
    case creditCard(lastFourDigits: String)
}

// Usage on Checkout Page:
let selectedPayment: PaymentMethod = .eWallet(.octo, phoneNumber: "08123456789")
// let selectedPayment: PaymentMethod = .creditCard(lastFourDigits: "1234")

switch selectedPayment {
case .cashOnDelivery:
    print("Pay cash directly to the courier")

case .bankTransfer(let bank):
    // Extracts the nested 'Bank' enum and reads its rawValue
    print("Please transfer to \(bank.rawValue)")

case .eWallet(let provider, let phone):
    // Extracts both the 'EWalletProvider' enum and the dynamic phone number string
    print("Opening the \(provider.rawValue) application for number \(phone)")

case .creditCard(let digits):
    // Extracts the dynamic card digits string
    print("Charging the credit card ending in \(digits)")
}

// MARK: - Summary
/*
Enum:
• Represents a fixed set of related values.
• Prevents invalid states.
• Improves readability and maintainability.
• Works naturally with switch.
• Compiler ensures every case is handled.
• Prefer enums over Strings or Integers whenever the possible values are known. (prone to typos, difficult to refactor, and not checked by the compiler)
*/
