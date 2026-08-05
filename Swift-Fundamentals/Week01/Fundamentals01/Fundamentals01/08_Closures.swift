import Foundation
/// **Closures**
/// A Closure is a self-contained block of code that can be stored, passed around, and executed later.
///
/// In simple terms:
/// A Closure is an **anonymous function (a function without a name).**
///
/// Why?
/// - Eliminates the need to create small one-time functions.
/// - Allows behavior to be passed as a value.
/// - Forms the foundation of many modern Swift APIs.
///
/// From an engineering perspective, closures are heavily used throughout SwiftUI, UIKit, Combine, GCD, URLSession, animations, and asynchronous programming.


// MARK: 1. Functions vs Closures
/// A regular function
func greet() {
    print("Hello")
}
greet()

/// Equivalent Closure
let greetClosure = {
    print("Hello")
}
greetClosure()

/// Difference:
///
/// Function
/// - Has a name.
/// - Reusable.
/// - Best when called multiple times.
///
/// Closure
/// - Anonymous.
/// - Usually used once.
/// - Passed into another function.


// MARK: Why Closures Exist
/// Imagine an API like this:
func performTask(action: () -> Void) {
    print("Starting...")
    action()
    print("Finished.")
}

/// Instead of creating another function:
func login() {
    print("Logging in...")
}
performTask(action: login)

/// You can write:
performTask {
    print("Logging in...")
}
/// This is cleaner because the behavior is only needed once.


// MARK: 2. Closure Syntax
let printWelcome = {
    print("Welcome!")
}
printWelcome()

/// General Syntax
/*
{
    statements
}
*/


// MARK: 3. Closures with Parameters
/// Closures can receive input just like functions.
let greetUser = { (name: String) in
    print("Hello \(name)")
}
greetUser("Taylor")

/// General Syntax
/*
{ (parameters) in
    statements
}
*/

// MARK: 4. Closures Returning Values
let square = { (number: Int) -> Int in
    number * number
}
let result = square(5)

// MARK: 5. Passing Closures into Functions
/// One of the most important concepts in Swift. Functions can accept closures as parameters.

func execute(action: () -> Void) {
    print("Start")
    action()
    print("Finish")
}
execute {
    print("Processing Payment")
}

/// Engineer Perspective
/// The function does not know WHAT will happen.
/// It simply knows WHEN to execute the provided behavior.

// MARK: 6. Trailing Closure Syntax
/// If the last parameter is a closure, Swift allows moving it outside the parentheses.
/// Instead of
execute(action: {
    print("Loading...")
})

/// We usually write
execute {
    print("Loading...")
}
/// This is called Trailing Closure Syntax. It is heavily used in SwiftUI.

// MARK: 7. Shorthand Argument Names
/// Swift automatically provides shorthand names for closure parameters.

let numbers = [1, 2, 3, 4]
let doubled = numbers.map {
    $0 * 2
}
/// $0 --> First parameter
/// $1 --> Second parameter
/// $2 --> Third parameter

/// Equivalent
let doubled2 = numbers.map { number in
    number * 2
}


// MARK: When to Avoid $0
/// Good
numbers.map {
    $0 * 2
}

/// Less Readable
/*
users.filter {
    $0.age > 18 &&
    $0.isVerified &&
    $0.country == "Indonesia"
}
*/

/// Prefer
/*
users.filter { user in
    user.age > 18 &&
    user.isVerified &&
    user.country == "Indonesia"
}
*/


// MARK: 8. Closures in the Standard Library
/// map
let prices = [10, 20, 30]
let doubledPrices = prices.map {
    $0 * 2
}

/// filter
let adults = users.filter {
    $0.age >= 18
}

/// sorted
let sortedUsers = users.sorted {
    $0.age < $1.age
}

/// forEach
users.forEach {
    print($0.name)
}

/// Engineer Perspective
/// Closures make collection transformations concise and expressive.


// MARK: 9. Closures in iOS Development
/// SwiftUI
/*
Button("Login") {
    login()
}
*/

/// Animation
/*
UIView.animate(withDuration: 0.3) {
    view.alpha = 0
}
*/

/// Dispatch Queue
/*
DispatchQueue.main.async {
    updateUI()
}
*/

/// URLSession
/*
URLSession.shared.dataTask(with: request) { data, response, error in

}
*/
/// Almost every Apple framework relies heavily on closures.


// MARK: 10. Function vs Closure
/// Use Functions
/// ✔ Logic is reused.
/// ✔ Public APIs.
/// ✔ Business logic.
/// ✔ Complex operations.

/// Use Closures
/// ✔ One-time behavior.
/// ✔ Callbacks.
/// ✔ UI actions.
/// ✔ Collection transformations.
/// ✔ Completion handlers.

// MARK: 11. Best Practices
/// ✔ Keep closures short.
/// ✔ Prefer functions when the logic becomes large.
/// ✔ Use meaningful parameter names instead of $0 when readability suffers.
/// ✔ Avoid deeply nested closures.


/// Good
/*
users.filter { user in

}
*/

/// Better than
/*
users.filter {

}
*/


// MARK: 12. Common Mistakes
/// ✖️ Using closures everywhere.
/// Sometimes a regular function is simpler.

/// ✖️ Overusing $0.
/// If the closure spans multiple lines, give parameters meaningful names.

/// ✖️ Writing very large closures.
/// Consider extracting business logic into a function.


// MARK: 13. Engineer Perspective
/// Closures allow us to pass behavior instead of data.
/// Instead of saying: "Here is a String.
///
/// We can now say:
/// "Here is some code. Execute it later.

/// This design powers:
/// • SwiftUI
/// • UIKit animations
/// • URLSession
/// • Combine
/// • Async callbacks
/// • Collection APIs


// MARK: - Summary
/*
Closures
────────────────────────────
• Anonymous functions.
• Can be stored and passed around.
• Execute behavior later.

Functions
────────────────────────────
• Named.
• Reusable.
• Best for business logic.

Closures
────────────────────────────
• Anonymous.
• Usually one-time.
• Great for callbacks.

Trailing Closures
────────────────────────────
• Cleaner syntax.
• Common in SwiftUI.

$0, $1
────────────────────────────
• Shorthand parameter names.
• Great for short closures.
• Avoid for complex logic.

Rule of Thumb
────────────────────────────
Reusable logic?
→ Function

One-time behavior?
→ Closure

Passing behavior?
→ Closure

Large closure?
→ Extract a function
*/

// to be continued
/*
 Level 1 (Wajib)
 Apa itu closure.
 Closure = anonymous function.
 Trailing closure syntax.
 Mengapa SwiftUI penuh closure.
 Mengapa UIKit penuh closure.
 Kapan memilih func vs closure.
 
 Level 2 (Wajib)
 Closure sebagai parameter.
 Passing function into function.
 Completion handler.
 Escaping closure (nanti).
 Async callback.
 
 Level 3 (Sering dipakai)
 map
 filter
 reduce
 sorted
 forEach
 $0, $1
 
 Level 4 (Advanced)
 Capturing values.
 Capture list [weak self].
 Escaping vs Non-escaping.
 Autoclosure.
 Sendable closure.

 note: need to explore
 func buatPembalap() -> () -> Void {
     var kecepatan = 0 // Variabel lokal fungsi
     
     // Closure menangkap variabel 'kecepatan'
     let balapan = {
         kecepatan += 10
         print("Kecepatan sekarang: \(kecepatan)")
     }
     return balapan
 }

 let gas = buatPembalap()
 gas() // Output: Kecepatan sekarang: 10
 gas() // Output: Kecepatan sekarang: 20 (Nilai luar tetap tersimpan!)

 Retain Cycle atau Strong Reference Cycle. Apakah Anda ingin tahu cara mencegahnya menggunakan [weak self]?
*/
