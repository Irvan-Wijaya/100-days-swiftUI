import Foundation

// MARK: - Overview
/// **Functions**
/// A function is a reusable block of code that performs a specific task.
///
/// Functions are one of the core building blocks of Swift. Almost every feature in an iOS application—from networking, business logic, UI rendering, to database operations—is organized into functions.
///
/// Why?
/// - Eliminates duplicated code.
/// - Improves readability.
/// - Makes code easier to test.
/// - Encourages modular architecture.
///
/// Engineer Perspective:
/// Well-designed functions should have one clear responsibility. This follows the Single Responsibility Principle (SRP).

// MARK: 1. Declaring Functions
/// Functions are declared using the `func` keyword.

func greet() {
    print("Hello")
}
greet()

/// Why?
/// Encapsulates reusable behavior.
/// Instead of repeating the same code multiple times, write it once and call it whenever needed.

// MARK: Naming Functions
/// Function names should describe an action.
///
/// ✔ Good
func fetchUserProfile() {}
func validateEmail() {}
func calculateTotalPrice() {}

/// ✖ Avoid
func process() {}
func doSomething() {}
func execute() {}
/// Good names reduce the need for comments.

// MARK: 2. Parameters
/// Parameters allow functions to receive input.
///
/// Why?
/// Makes functions reusable instead of relying on hardcoded values.

func greet(name: String) {
    print("Hello \(name)")
}
greet(name: "Taylor")
greet(name: "Irvan")

// MARK: Multiple Parameters
func transfer(amount: Decimal, from sender: String, to receiver: String) {
    print("Transaction success from \(sender) to \(receiver) with amount: \(amount)")
}
transfer(amount: 500_000, from: "Savings", to: "Investment")

/// Engineer Perspective
/// Parameters should represent everything required to perform the task. Avoid reading global state whenever possible.

// MARK: External vs Internal Parameter Names
/// Swift separates API readability
/// from implementation details.

func greet(to name: String) {
    print(name)
}
greet(to: "Taylor")
/// External name: to
/// Internal name: name

/// Why?
///Produces APIs that read like English.

/// Example
func move(from source: String, to destination: String) {

}
/// Reads naturally:
move(from: "Home",to: "Office")

// MARK: Omitting External Labels
/// Use `_` only when the argument is obvious.

func square(_ number: Int) -> Int {
    number * number
}
square(5)

/// Good
login("Taylor", "123456")

/// Prefer
login(username: "Taylor",password: "123456")

// MARK: 3. Return Values
/// A function can return a result.

func calculateTax(amount: Decimal) -> Decimal {
    amount * 0.11
}
let tax = calculateTax(amount: 100_000)

/// Why?
/// Returning values makes functions predictable and testable.

// MARK: Void Functions
/// Not every function returns a value.

func showLoading() {
    print("Loading")
}

/// Equivalent
func showLoading2() -> Void {
}

// MARK: Single Expression Functions
/// Swift allows returning a single expression implicitly.

func double(_ number: Int) -> Int {
    number * 2
}

// MARK: 4. Multiple Return Values
/// Swift uses tuples to return multiple related values.

func fetchUser() -> (name: String, age: Int) {
    ("Taylor", 30)
}

let user = fetchUser()
print(user.name)
print(user.age)

// MARK: Tuple Destructuring
/// Destructuring extracts values
/// from a tuple into separate variables.

let (name, age) = fetchUser()
print(name)
print(age)

/// Why?
/// Cleaner than repeatedly accessing tuple properties.

/// Real-world case
func getScreenSize() -> (width: Double, height: Double) {
    (390, 844)
}
let (width, height) = getScreenSize()

// MARK: Ignoring Tuple Values
let (username, _) = fetchUser()
/// Ignore values
/// that are not needed.

// MARK: 5. Throwing Functions
/// Some operations can fail.
/// Swift models this explicitly using `throws`.

enum LoginError: Error {
    case invalidCredential
    case networkUnavailable
    case serverError
}

func login(username: String, password: String) throws {
    guard username == "admin" else {
        throw LoginError.invalidCredential
    }
}

/// Calling
do {
    try login(username: "admin", password: "123456")
}
catch {
    print(error)
}

/// Why?
/// Makes failures explicit. Prevents silently ignoring errors.

// MARK: Real Examples
/// Networking
func fetchProfile() throws {

}

// MARK: When NOT to use throws
/// Don't use throws for expected business states.

/// Bad
/*
func login(...) throws {
    throw LoginError.invalidPassword
}
*/

/// Better
enum LoginResult {
    case success
    case invalidCredential
}

// Because invalid credentials are often an expected outcome rather than an exceptional system failure.
// Use `throws` for unexpected failures:
// • Network unavailable
// • Disk write failed
// • JSON decoding failed
// • Permission denied

// MARK: 6. Best Practices
/// ✔ One function should perform
/// one responsibility.

/// Good
func validateEmail() {}
func saveUser() {}

/// Avoid
func validateSaveUploadSendEmail() {}

/// ✔ Keep functions short. A function should usually fit on one screen.
/// ✔ Use meaningful names.

/// Prefer
fetchProfile()

/// instead of
getData()

// MARK: Common Mistakes
/// ✖ Too many parameters

/*
func transfer(amount: Decimal, from: String, to: String, note: String, schedule: Date, pin: String, biometric: Bool)
*/
/// Consider grouping related data into a struct.

/// ✖ Side Effects
/// Avoid modifying unrelated state.
/// Functions should be predictable.

// MARK: Engineering Perspective
/// Example:
/// Feature:
/// Transfer Money
///
/// Bad
/*
func transfer() {
    validate()
    fetchBalance()
    saveDatabase()
    callAPI()
    sendNotification()
}
*/

/// Better

validateTransfer()
fetchBalance()
performTransfer()
saveHistory()
sendNotification()

/// Each function has one clear purpose,
/// making testing and maintenance easier.

// MARK: Summary
/*
Functions
────────────────────────────
• Reusable blocks of code.
• Improve readability.
• Reduce duplication.

Parameters
────────────────────────────
• Provide input.
• Increase reusability.

Return Values
────────────────────────────
• Produce results.
• Easier to test.

Tuples
────────────────────────────
• Return multiple values.
• Can be destructured.

Throws
────────────────────────────
• Represents unexpected failures.
• Must be handled explicitly.

Rule of Thumb
────────────────────────────
One Function
One Responsibility

Short, Predictable, Reusable
*/
