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

enum PaymentMethod {
    case cash
    case creditCard
}

enum DeliveryMethod {
    case pickup
    case shipping
}

let payment = PaymentMethod.cash

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
