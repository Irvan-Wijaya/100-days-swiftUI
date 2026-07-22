import Foundation

// MARK: - Overview
/// **Type Annotations**
/// Type Annotations explicitly declare the type of a variable or constant. Although Swift provides powerful Type Inference, explicit types improve code clarity, communicate developer intent, and are required in certain situations.
/// From an engineering perspective, Type Annotations make code easier to understand, maintain, and prevent unintended type inference.

// MARK: 1. Type Inference
/// Swift automatically determines a value's type from its initial value. This feature is called Type Inference.
/*
let name = "Irvan"              // String
let age = 24                    // Int
let height = 175.5              // Double
let isPremiumUser = true         // Bool
 */

/// Why?
/// - Cleaner, less verbose code.
/// - Preferred when the type is obvious.
/// - Commonly used throughout Swift and Apple's frameworks.

// MARK: 2. Type Annotation
/// Type Annotations explicitly specify a value's type.
/*
let username: String = "Irvan"
let retryCount: Int = 3
let apiTimeout: TimeInterval = 30
let accountBalance: Decimal = 1_000_000
*/
/// Why?
/// - Makes the intended type explicit.
/// - Improves readability.
/// - Prevents unintended type inference.
/// - Acts as lightweight documentation for other developers.

// MARK: 3. When Type Annotation is Required

/// Swift cannot infer a type when no initial value exists.

// Empty Array
var users: [String] = []

// Empty Dictionary
//var scores: [String: Int] = [:] |  error -> Invalid redeclaration of 'scores'

// Empty Set
//var favoriteActors: Set<String> = [] | error -> Invalid redeclaration of 'favoriteActors'

/// Without explicit types, the compiler has no information
/// about what element type should be stored.

// MARK: 4. When Type Annotation Improves Code
/// Example 1
let timeout: TimeInterval = 30

/// Better than:
let timeout2 = 30
/// Because "30" alone doesn't communicate, whether it's seconds, milliseconds, or minutes.

/// Example 2
let amount: Decimal = 99.99

/// Better than:
let amount2 = 99.99
/// Because Swift would infer Double, which is generally not recommended for financial calculations.

// MARK: 5. Type Safety
/// Swift is a strongly type-safe language. Once a type is determined, only compatible values can be assigned.

var score = 100
// score = "One Hundred"
// ✖️ Error

// MARK: 6. Best Practices
/// ✔️ Prefer Type Inference when the type is obvious.

let city = "Jakarta"
let isLoggedIn = true
let scoresList = [80, 90, 100]

/// ✔️ Use Type Annotation when:
///
/// - Creating empty collections.
/// - A specific type is required.
/// - The type carries important business meaning.
/// - Explicit intent improves readability.

let interestRate: Decimal = 0.05
let locationLatitude: Double = -6.2088

// MARK: 7. Engineer Perspective
/// Type Inference reduces boilerplate and keeps code concise.
///
/// Type Annotation communicates intent.
///
/// Good Swift code balances both:
/// Prefer inference by default,
/// but annotate whenever clarity or correctness benefits.

// MARK: - Summary

/*
Type Inference
────────────────────────────
• Compiler determines the type.
• Cleaner and more concise.
• Preferred when the type is obvious.

Type Annotation
────────────────────────────
• Developer explicitly specifies the type.
• Required for empty collections.
• Improves readability.
• Prevents unintended type inference.
• Documents developer intent.

Rule of Thumb
────────────────────────────
Use Type Inference by default.

Add Type Annotations when:
• The compiler needs help.
• The exact type matters.
• The code becomes easier to understand.
*/
