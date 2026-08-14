import Foundation

// MARK: - Overview
/// **Control Flow**
/// Control Flow determines the order in which code executes. Almost every application—from banking apps to games—relies on control flow to make decisions, repeat tasks, and respond to user interactions.
/// From an engineering perspective, choosing the right control flow improves readability, maintainability, and reduces logical bugs.

// MARK: 1. Decision Making with if
/// `if` executes a block of code only when a condition evaluates to `true`.
///
/// Why?
/// - Handles dynamic decisions.
/// - Keeps business logic simple.
/// - Best for evaluating one or a few conditions.

let isLoggedIn = true

if isLoggedIn {
    print("Navigate to Home")
}

/// Multiple conditions
let balance = 2_000
let minimumBalance = 1_000

if balance >= minimumBalance {
    print("Transfer Allowed")
} else {
    print("Insufficient Balance")
}

/// Multiple branches
let score = 88
if score >= 90 {
    print("Excellent")
} else if score >= 75 {
    print("Passed")
} else {
    print("Failed")
}

// MARK: Why not use many else-if?
/// Long else-if chains become difficult to read and harder to maintain.

/// ✖️ Avoid
/*
if state == .idle {

} else if state == .loading {

} else if state == .success {

} else if state == .failure {

}
*/

/// Consider using `switch` instead.

// MARK: 2. Switch Statements
/// `switch` compares a value against multiple known possibilities.
///
/// Why?
/// - Cleaner than long if-else chains.
/// - Required for many enum-based state machines.
/// - Compiler ensures every case is handled.

enum LoginState {
    case idle
    case loading
    case success
    case failure
}

let state = LoginState.loading

switch state {
case .idle:
    print("Idle")
case .loading:
    print("Loading...")
case .success:
    print("Success")
case .failure:
    print("Failed")
}

/// Unlike many other languages, Swift's switch does NOT fall through automatically.

// MARK: Exhaustiveness Checking
/// Swift requires every enum case to be handled.
/// If a new enum case is added, every switch must be updated. This prevents forgotten business logic and makes refactoring safer.

// MARK: 3. Ternary Conditional Operator
/// A shorthand form of if-else.
///
/// Syntax:
/// condition ? valueIfTrue : valueIfFalse

let age = 20
let message = age >= 18
    ? "Adult"
    : "Minor"

/// Why?
/// - Concise.
/// - Great for simple value selection.

// MARK: When NOT to use Ternary
/// ✖️ Avoid nested ternary operators.
let title = isLoading ? "Loading..." : hasError ? "Retry" : "Continue"
/// Prefer if-else when the logic becomes difficult to read.

// MARK: 4. Choosing the Right Tool
/// Use `if`
/// • Two or three conditions.
/// • Complex boolean expressions.
/// • Range checking.
/// • Independent conditions.

/// Use `switch`
/// • Multiple known cases.
/// • Enum values.
/// • Pattern matching.
/// • State management.

/// Use ternary
/// • Simple value assignment.
/// • One-line conditional expressions.
///
/// Avoid using ternary for complex business logic.

// MARK: 5. Engineering Perspective
/// Real-world examples:
/// Authentication
if isLoggedIn {
    print("Home Screen")
} else {
    print("Login Screen")
}

/// Permission Handling
let hasCameraPermission = false
if hasCameraPermission {
    print("Open Camera")
} else {
    print("Request Permission")
}

/// Application State
switch state {
case .idle:
    break
case .loading:
    print("Show Spinner")
case .success:
    print("Display Data")
case .failure:
    print("Show Error")
}

// MARK: 6. Best Practices
/// ✔️ Prefer positive conditions.
if isLoggedIn {

}

/// Better than

// if !isGuest {
/// ✔️ Prefer early exits (guard)
/// for complex functions.
/// (Covered in a later chapter.)

/// ✔️ Prefer switch when working with enums.
/// ✔️ Keep conditions simple.

/// Instead of:

// if age > 18 && hasPermission && !isSuspended && isVerified ...
/// Consider extracting business logic into a computed property or helper function.

// MARK: 7. Common Mistakes
/// ✖️ Comparing booleans with true/false.
// if isLoggedIn == true

/// ✔️
if isLoggedIn {

}

/// ✖️ Nested if statements that are too deep. Prefer early return (guard) or split logic into smaller functions.

// MARK: - Summary
/*
if
────────────────────────────
• Best for simple decisions.
• Handles boolean expressions.
• Ideal for 2–3 conditions.

switch
────────────────────────────
• Best for multiple known cases.
• Perfect with enums.
• Compiler checks exhaustiveness.
• More maintainable than long else-if chains.

Ternary Operator
────────────────────────────
• Best for simple value assignment.
• Improves conciseness.
• Avoid nested ternary expressions.

Rule of Thumb
────────────────────────────
Need a simple decision?
→ if

Need to handle many known states?
→ switch

Need to assign one value based on one condition?
→ Ternary
*/

// MARK: 2. Loop Statements

/// Loops repeatedly execute a block of code until a condition is met or every element in a collection has been processed.
///
/// Why?
/// - Eliminates repetitive code.
/// - Makes programs scalable.
/// - Essential for processing collections and API responses.
///
/// From an engineering perspective, loops are most commonly used for:
/// - Iterating Arrays, Dictionaries, and Sets.
/// - Processing JSON/API responses.
/// - Validating multiple inputs.
/// - Updating UI models.

// MARK: 2.1 for-in Loop
/// `for-in` iterates through every element in a collection.
///
/// Why?
/// - Safe.
/// - Readable.
/// - Preferred loop in modern Swift.
///
/// When?
/// - Processing Arrays.
/// - Processing Dictionaries.
/// - Processing Sets.
/// - Iterating ranges.

let fruits = ["Apple", "Banana", "Orange"]
for fruit in fruits {
    print(fruit)
}

// MARK: Ranges
/// Closed Range (...)
for number in 1...5 {
    print(number)
}
/// Output: 1 2 3 4 5

/// Half-Open Range (..<)
for number in 1..<5 {
    print(number)
}
/// Output: 1 2 3 4

// MARK: Dictionary Iteration
let employee = [
    "Name": "Taylor",
    "Role": "iOS Engineer"
]
for (key, value) in employee {
    print("\(key): \(value)")
}

// MARK: Set Iteration
let languages: Set<String> = ["Swift", "Kotlin", "Java"]
for language in languages {
    print(language)
}
/// Note:
/// Sets are unordered. The iteration order is not guaranteed.

// MARK: Enumerated
/// Use `enumerated()` when both the index and element are required.

for (index, fruit) in fruits.enumerated() {
    print("\(index): \(fruit)")
}

// MARK: 2.2 while Loop
/// `while` repeatedly executes a block while its condition remains true.
///
/// Why?
/// The number of iterations is unknown.
///
/// When?
/// Retry logic, Polling, Waiting for a condition.

var retryCount = 0
while retryCount < 3 {
    print("Retry API")
    retryCount += 1
}

// MARK: 2.3 repeat-while
/// `repeat-while` executes the body first, then checks the condition. It always executes at least once.

var number = 5
repeat {
    print(number)
} while number < 3

/// Output: 5

// MARK: 3. Loop Control Statements
/// Loop control statements alter the normal execution flow of loops.

// MARK: break
/// `break` immediately exits the current loop.

for number in 1...10 {
    if number == 5 {
        break
    }
    print(number)
}

/// Output:
/// 1
/// 2
/// 3
/// 4

/// When?
/// - Stop searching once the target is found.
/// - Exit early to improve performance.

// MARK: continue
/// `continue` skips the current iteration and moves directly to the next one.

for number in 1...5 {
    if number == 3 {
        continue
    }
    print(number)
}

/// Output:
/// 1
/// 2
/// 4
/// 5

/// When?
/// Skip invalid data while continuing to process the remaining elements.

// MARK: Choosing the Right Loop
/// for-in
/// • Preferred loop in Swift.
/// • Iterating collections.
/// • Known number of iterations.
///
/// while
/// • Unknown number of iterations.
/// • Waiting for a condition.
/// • Retry logic.
///
/// repeat-while
/// • Execute at least once.
/// • Rarely used.

// MARK: Engineering Perspective
/// Example 1
/// Displaying a transaction list.

let transactions = ["Transfer", "Top Up","Payment"]

for transaction in transactions {
    print(transaction)
}
/// Example 2
/// Retry API request.

var attempts = 0
while attempts < 3 {
    print("Calling API...")
    attempts += 1
}

/// Example 3
/// Skip invalid records.

let scores = [
    80,
    -1,
    95,
    -1,
    100
]

for score in scores {
    if score < 0 {
        continue
    }
    print(score)
}

// MARK: Best Practices
/// ✔️ Prefer `for-in` over index-based loops.
for fruit in fruits {
    print(fruit)
}

/// Better than:

/*
for i in 0..<fruits.count {
    print(fruits[i])
}
*/

/// unless the index is actually needed.
/// ✔️ Use `enumerated()` when both index and value are required.
/// ✔️ Prefer meaningful variable names.

for transaction in transactions {

}

/// Better than

/*
for item in transactions {

}
*/

/// ✔️ Keep loop bodies small.

/// If the loop becomes too complex,
/// move the logic into a separate function.

// MARK: Common Mistakes

/// ✖️ Infinite Loop
/*
while true {

}
*/

/// Always ensure the condition eventually becomes false.

/// ✖️ Off-by-one Error -> Index out of range
/*
for i in 0...fruits.count {

}
*/

/// This crashes because the last valid index is count - 1.
/// Prefer iterating directly over the collection.

// MARK: Summary
/*
for-in
────────────────────────────
• Preferred loop in Swift.
• Best for collections.
• Safe and readable.

while
────────────────────────────
• Unknown number of iterations.
• Retry and polling.

repeat-while
────────────────────────────
• Executes at least once.
• Rarely used.

break
────────────────────────────
• Immediately exits the loop.

continue
────────────────────────────
• Skips the current iteration.

Rule of Thumb
────────────────────────────
Processing a collection?
→ for-in

Waiting until a condition changes?
→ while

Need to execute once before checking?
→ repeat-while

Need to stop immediately?
→ break

Need to skip one iteration?
→ continue
*/


// MARK: 4. Optional Binding

/// Optional Binding safely unwraps an Optional value.
///
/// It combines two operations:
/// 1. Check whether the Optional contains a value.
/// 2. Bind the unwrapped value to a new constant.
///
/// Common forms:
/// - if let
/// - guard let
///
/// Why?
/// Optionals may contain a value or nil.
/// Swift prevents direct access to an Optional's underlying value
/// until the possibility of nil has been handled.

// MARK: 4.1 if let

/// Use `if let` when the logic should execute
/// only when the Optional contains a value.

let username: String? = "Irvan"

if let username {
    print("Welcome \(username)")
}

/// Inside the block, `username` is a `String`,
/// not a `String?`.


/// Handle both possibilities:

if let username {
    print("Welcome \(username)")
} else {
    print("Username is unavailable")
}


// MARK: Multiple Optional Bindings

let token: String? = "abc123"
let userID: String? = "USER-001"

if let token,
   let userID {

    print("Token:", token)
    print("User ID:", userID)
}


// MARK: Optional Binding with Conditions

let age: Int? = 24

if let age,
   age >= 18 {

    print("User is an adult")
}


// MARK: 4.2 guard let

/// Use `guard let` when a value is required
/// for the current scope to continue.
///
/// If the condition fails, the `else` block
/// must exit the current scope.

func submitTransfer(token: String?) {

    guard let token else {
        return
    }

    print("Submitting transfer with token:", token)
}

/// After the guard succeeds,
/// `token` remains available throughout
/// the rest of the function.


// MARK: Why guard?

/// `guard` is especially useful for
/// validating prerequisites at the beginning
/// of a function.
///
/// It prevents deeply nested `if` statements.

func processPayment(
    token: String?,
    amount: Decimal?,
    accountID: String?
) {

    guard let token else {
        return
    }

    guard let amount,
          amount > 0 else {
        return
    }

    guard let accountID else {
        return
    }

    // Main business logic remains flat.

    print(
        "Payment:",
        token,
        amount,
        accountID
    )
}


// MARK: Industry Example - Networking

func handleResponse(
    data: Data?,
    response: URLResponse?,
    error: Error?
) {

    guard error == nil else {
        print("Network error")
        return
    }

    guard let response = response as? HTTPURLResponse else {
        print("Invalid response")
        return
    }

    guard response.statusCode == 200 else {
        print("Server returned:", response.statusCode)
        return
    }

    guard let data else {
        print("Empty response")
        return
    }

    decode(data)
}


// MARK: if let vs guard let

/// `if let`:
/// "If the value exists, execute this logic."

if let imageURL {
    imageView.load(imageURL)
}

/// `guard let`:
/// "This value is required.
/// If it is unavailable, stop."

guard let imageURL else {
    return
}

imageView.load(imageURL)


// MARK: 4.3 Nil-Coalescing

/// Use `??` when a simple fallback value is sufficient.

let displayName = username ?? "Guest"

/// Rule:
///
/// Need a block of logic?
/// → if let / guard let
///
/// Need a simple fallback value?
/// → ??


/*
Example:

if let username {
    showWelcomeScreen(username)
} else {
    showLoginScreen()
}

The two paths have different behavior,
so `if let` is appropriate.

But:

let displayName = username ?? "Guest"

Only a fallback value is needed,
so nil-coalescing is simpler.
*/


// MARK: 4.4 if case

/// `if case` is useful for matching
/// a specific enum case and extracting
/// its associated value.

enum LoginState {
    case idle
    case loading
    case success(String)
    case failure(Error)
}

let state = LoginState.success("Irvan")

if case let .success(username) = state {
    print("Logged in as:", username)
}


// MARK: 4.5 guard case

/// `guard case` works similarly,
/// but exits early if the pattern does not match.

func handleLogin(state: LoginState) {

    guard case let .success(username) = state else {
        return
    }

    print("Continue with:", username)
}


// MARK: Engineer Perspective

/// Prefer `if let` when:
/// - Both success and failure paths are meaningful.
/// - The value is only needed inside a specific block.
///
/// Prefer `guard let` when:
/// - The value is required for the rest of the scope.
/// - Failure means the current operation cannot continue.
/// - Multiple prerequisites need validation.
/// - You want to avoid nested control flow.
///
/// Prefer `??` when:
/// - A simple fallback value is enough.
///
/// Prefer `if case` / `guard case` when:
/// - Working with enums and pattern matching.


// MARK: Common Mistakes

/// Avoid unnecessary force unwrapping:

// let name = username!

/// Prefer:

if let username {
    print(username)
}

/// Avoid deeply nested Optional Binding:

/*
if let user {
    if let account {
        if let token {
            performTransfer()
        }
    }
}
*/

/// Prefer early exits:

guard let user else {
    return
}

guard let account else {
    return
}

guard let token else {
    return
}

performTransfer()


// MARK: - Summary

/*
Optional Binding
────────────────────────────
Safely extracts a value from an Optional.

if let
────────────────────────────
Use when:
• The value may or may not exist.
• Different success/failure behavior is required.
• The value is only needed inside a block.

guard let
────────────────────────────
Use when:
• The value is required to continue.
• Failure should exit early.
• Multiple prerequisites need validation.

?? (Nil Coalescing)
────────────────────────────
Use when:
• A simple fallback value is enough.

if case / guard case
────────────────────────────
Use when:
• Matching specific enum cases.
• Extracting associated values.

Rule of Thumb
────────────────────────────
Need the value only inside a branch?
→ if let

Need the value for the rest of the scope?
→ guard let

Need a fallback value?
→ ??

Need to match an enum case?
→ if case / guard case
*/
