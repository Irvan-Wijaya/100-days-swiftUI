import Foundation

// MARK: - Overview
/// **Control Flow**
/// Control Flow determines the order in which code executes.
/// Almost every application—from banking apps to games—relies on control flow
/// to make decisions, repeat tasks, and respond to user interactions.
///
/// From an engineering perspective, choosing the right control flow improves
/// readability, maintainability, and reduces logical bugs.

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

/// Long else-if chains become difficult to read
/// and harder to maintain.

/// ❌ Avoid

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

/// Unlike many other languages,
/// Swift's switch does NOT fall through automatically.

// MARK: Exhaustiveness Checking

/// Swift requires every enum case to be handled.
///
/// If a new enum case is added,
/// every switch must be updated.
///
/// This prevents forgotten business logic
/// and makes refactoring safer.

// MARK: 3. Ternary Conditional Operator

/// A shorthand form of if-else.
///
/// Syntax:
///
/// condition ? valueIfTrue : valueIfFalse

let age = 20

let message = age >= 18
    ? "Adult"
    : "Minor"

/// Why?
/// - Concise.
/// - Great for simple value selection.

// MARK: When NOT to use Ternary

/// ❌ Avoid nested ternary operators.

/*
let title =
isLoading
?
"Loading..."
:
hasError
?
"Retry"
:
"Continue"
*/

/// Prefer if-else when the logic becomes difficult to read.

// MARK: 4. Choosing the Right Tool

/// Use `if`
///
/// • Two or three conditions.
/// • Complex boolean expressions.
/// • Range checking.
/// • Independent conditions.

/// Use `switch`
///
/// • Multiple known cases.
/// • Enum values.
/// • Pattern matching.
/// • State management.

/// Use ternary
///
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

/// ✅ Prefer positive conditions.

if isLoggedIn {

}

/// Better than

// if !isGuest {

/// ✅ Prefer early exits (guard)
/// for complex functions.
/// (Covered in a later chapter.)

/// ✅ Prefer switch when working with enums.

/// ✅ Keep conditions simple.

/// Instead of:

// if age > 18 && hasPermission && !isSuspended && isVerified ...

/// Consider extracting business logic into a computed property
/// or helper function.

// MARK: 7. Common Mistakes

/// ❌ Comparing booleans with true/false.

// if isLoggedIn == true

/// ✅

if isLoggedIn {

}

/// ❌ Nested if statements that are too deep.

/// Prefer early return (guard)
/// or split logic into smaller functions.

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
