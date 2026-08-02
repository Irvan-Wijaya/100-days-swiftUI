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
