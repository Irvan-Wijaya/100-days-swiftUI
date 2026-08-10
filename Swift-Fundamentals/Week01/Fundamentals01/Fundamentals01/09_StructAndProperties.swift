import Foundation

// MARK: - Overview

/// **Structs and Properties**
///
/// Structs are value types used to model data and behavior.
///
/// SwiftUI relies heavily on structs:
/// - View
/// - ViewModifier
/// - Configuration objects
/// - UI state models
/// - Domain models
///
/// This chapter covers:
/// - Structs
/// - Initializers
/// - Stored properties
/// - Computed properties
/// - Property observers
/// - Access control
/// - Static properties and methods
///
/// Engineer Perspective:
/// Good struct design is about modeling state,
/// controlling mutation, and exposing a clear API.


// MARK: 1. Structs

/// A struct groups related data and behavior
/// into a single type.

struct User {

    let id: String
    var name: String

    func greeting() -> String {
        "Hello, \(name)"
    }
}

let user = User(
    id: "123",
    name: "Taylor"
)

print(user.greeting())


// MARK: Why Struct?

/// Structs are value types.
///
/// Assigning a struct creates an independent value.

var user1 = User(
    id: "1",
    name: "Taylor"
)

var user2 = user1

user2.name = "John"

print(user1.name) // Taylor
print(user2.name) // John


/// This behavior is fundamentally different
/// from reference types such as classes.
///
/// Value semantics make structs predictable
/// and reduce unintended shared state.


// MARK: 2. Initializers

/// An initializer creates an instance
/// of a struct.
///
/// Swift automatically provides a memberwise initializer
/// when possible.

struct Account {

    let id: String
    var balance: Decimal
}

let account = Account(
    id: "ACC-001",
    balance: 1_000
)


// MARK: Custom Initializer

/// You can create your own initializer
/// when custom setup or validation is required.

struct UserProfile {

    let username: String
    let displayName: String

    init(username: String) {

        self.username = username
        self.displayName = username.capitalized
    }
}

let profile = UserProfile(
    username: "irvan"
)


// MARK: Default Values

/// Properties can have default values.
///
/// This makes certain parameters optional
/// during initialization.

struct APIConfiguration {

    let baseURL: String
    let timeout: TimeInterval = 30
}

let configuration = APIConfiguration(
    baseURL: "https://api.example.com"
)


/// The caller can still override the default:

let customConfiguration = APIConfiguration(
    baseURL: "https://api.example.com",
    timeout: 60
)


// MARK: Optional Properties

/// Optional properties are useful when
/// a value may legitimately not exist.

struct UserSession {

    let userID: String
    var accessToken: String?
}

let session = UserSession(
    userID: "123",
    accessToken: nil
)


/// Important distinction:
///
/// Default value:
/// A value is provided automatically.
///
/// Optional:
/// The value is allowed to be absent.
///
/// These concepts are independent.


// MARK: 3. Stored Properties

/// A stored property stores actual data
/// inside the instance.

struct Product {

    let id: String
    var price: Decimal
    var quantity: Int
}

/// `id`, `price`, and `quantity`
/// are stored properties.


// MARK: 4. Computed Properties

/// A computed property does not store a value.
///
/// Instead, it calculates a value
/// whenever it is accessed.

struct ProductSummary {

    let price: Decimal
    let quantity: Int

    var totalPrice: Decimal {
        price * Decimal(quantity)
    }
}

let product = ProductSummary(
    price: 10,
    quantity: 3
)

print(product.totalPrice)


/// Why?
///
/// Prevents duplicated state.
///
/// Instead of storing:

/*
var totalPrice: Decimal
*/

/// We calculate it from
/// the source of truth:

/*
price
quantity
*/

/// This prevents values from becoming inconsistent.


// MARK: Engineer Perspective

/// Prefer computed properties when
/// a value can be derived from existing state.
///
/// Example:

struct User {

    let firstName: String
    let lastName: String

    var fullName: String {
        "\(firstName) \(lastName)"
    }
}


// MARK: 5. Getters and Setters

/// Computed properties can have
/// a getter and setter.

struct Temperature {

    var celsius: Double

    var fahrenheit: Double {

        get {
            celsius * 9 / 5 + 32
        }

        set {
            celsius = (newValue - 32) * 5 / 9
        }
    }
}

var temperature = Temperature(
    celsius: 25
)

print(temperature.fahrenheit)

temperature.fahrenheit = 86

print(temperature.celsius)


/// `get`
/// Defines how the value is read.
///
/// `set`
/// Defines how the value is modified.
///
/// `newValue`
/// Represents the value assigned
/// to the property.


// MARK: When to Use get/set

/// Use get/set when two representations
/// of the same underlying state need
/// to stay synchronized.
///
/// Common examples:
/// - Unit conversion
/// - Data transformation
/// - Controlled mutation
///
/// In everyday iOS development,
/// read-only computed properties are
/// significantly more common.


// MARK: 6. Property Observers

/// Property observers allow code to execute
/// when a stored property's value changes.
///
/// Swift provides:
///
/// `willSet`
/// Runs before the value changes.
///
/// `didSet`
/// Runs after the value changes.

struct Download {

    var progress: Double {

        willSet {
            print("Progress will change")
        }

        didSet {
            print("Progress changed")
        }
    }
}

var download = Download(
    progress: 0
)

download.progress = 0.5


// MARK: willSet

/// `willSet` provides access to
/// the incoming value through `newValue`.

struct Account {

    var balance: Decimal {

        willSet {
            print("New balance: \(newValue)")
        }
    }
}


// MARK: didSet

/// `didSet` provides access to
/// the previous value through `oldValue`.

struct Counter {

    var value: Int {

        didSet {
            print(
                "Changed from \(oldValue) to \(value)"
            )
        }
    }
}


// MARK: Industry Use Cases

/// Property observers can be useful for:
///
/// - Logging state changes
/// - Triggering lightweight side effects
/// - Updating dependent state
/// - Debugging
/// - Analytics
///
/// Example:

struct ViewState {

    var isLoading: Bool {

        didSet {

            print(
                "Loading state:",
                isLoading
            )
        }
    }
}


/// However:
///
/// Avoid putting heavy business logic
/// inside property observers.
///
/// Prefer explicit functions or
/// dedicated state-management logic
/// when the behavior becomes complex.


// MARK: 7. Access Control

/// Access control determines
/// who can access a type or member.
///
/// Swift provides several levels:
///
/// private
/// fileprivate
/// internal
/// package
/// public
/// open
///
/// `internal` is the default.


// MARK: private

/// Accessible only within
/// the enclosing declaration
/// and its extensions.

struct BankAccount {

    private var balance: Decimal = 0

    mutating func deposit(
        amount: Decimal
    ) {

        balance += amount
    }
}


// MARK: fileprivate

/// Accessible anywhere
/// within the same Swift source file.


// MARK: internal

/// Default access level.
///
/// Accessible anywhere within
/// the same module/application.

struct UserService {

    internal func fetchUser() {

    }
}


// MARK: public

/// Accessible from another module.
///
/// Common when building frameworks
/// or reusable libraries.


// MARK: open

/// Similar to public, but additionally
/// allows subclassing and overriding
/// from another module.
///
/// Mostly relevant to framework design.


// MARK: Engineer Perspective - Access Control

/// Access control is about
/// protecting invariants and
/// controlling your public API.
///
/// Example:

struct BankBalance {

    private(set) var balance: Decimal = 0

    mutating func deposit(
        amount: Decimal
    ) {

        balance += amount
    }
}

/// `private(set)` means:
///
/// Anyone can READ the balance,
/// but only the struct itself
/// can MODIFY it.
///
/// This is extremely useful
/// for encapsulation.


// MARK: 8. Static Properties

/// `static` creates a property
/// that belongs to the TYPE itself,
/// rather than each instance.

struct AppConfiguration {

    static let apiVersion = "v1"

}

print(AppConfiguration.apiVersion)


/// Without static:

let config1 = AppConfiguration()
let config2 = AppConfiguration()

/// Each instance would have
/// its own properties.
///
/// With static:
///
/// AppConfiguration.apiVersion
///
/// There is one value associated
/// with the type.


// MARK: Static Methods

struct Logger {

    static func log(
        _ message: String
    ) {

        print("[LOG]", message)
    }
}

Logger.log("User logged in")


// MARK: Static vs Instance

struct Math {

    static let pi = 3.14159

    func square(
        _ number: Double
    ) -> Double {

        number * number
    }
}

/// Type-level:

Math.pi

/// Instance-level:

let math = Math()

math.square(5)


// MARK: Engineer Perspective

/// `static` is useful for:
///
/// - Constants
/// - Factory methods
/// - Utility behavior
/// - Configuration
/// - Namespacing
///
/// Example:

struct APIEndpoint {

    static let baseURL =
        "https://api.example.com"

    static func user(
        id: String
    ) -> String {

        "\(baseURL)/users/\(id)"
    }
}


// MARK: 9. Static Factory Methods

/// A common professional pattern
/// is using static methods
/// to create configured instances.

struct NetworkRequest {

    let endpoint: String

    static func user(
        id: String
    ) -> NetworkRequest {

        NetworkRequest(
            endpoint: "/users/\(id)"
        )
    }
}

let request = NetworkRequest.user(
    id: "123"
)


// MARK: 10. SwiftUI Connection

/// SwiftUI uses structs extensively.

/// Example:

/*
struct LoginView: View {

    let title: String

    var body: some View {

        Text(title)

    }
}
*/

/// SwiftUI Views are value types.
///
/// SwiftUI can create and recreate
/// View values efficiently as state changes.
///
/// This is one of the reasons
/// understanding structs and
/// value semantics is important
/// for SwiftUI development.


// MARK: Best Practices

/// ✔ Prefer structs for data models
/// and lightweight value-based types.

/// ✔ Prefer `let` when state
/// should not change.

/// ✔ Prefer computed properties
/// instead of storing derived state.

/// ✔ Keep property observers lightweight.

/// ✔ Use access control to protect
/// internal implementation details.

/// ✔ Use `private(set)` when consumers
/// should read but not directly modify state.

/// ✔ Use `static` for type-level
/// constants and behavior.

/// ✔ Avoid unnecessary custom initializers.
/// Let Swift synthesize the memberwise
/// initializer when appropriate.


// MARK: Common Mistakes

/// ❌ Storing derived state unnecessarily.

/// Bad:

/*
struct Cart {

    var price: Decimal
    var quantity: Int
    var total: Decimal
}
*/

/// `total` can become inconsistent
/// with `price` and `quantity`.

/// Better:

/*
var total: Decimal {
    price * Decimal(quantity)
}
*/


/// ❌ Exposing mutable state unnecessarily.

/*
struct User {

    var token: String
}
*/

/// Prefer:

/*
private(set) var token: String
*/


/// ❌ Putting heavy business logic
/// inside `didSet`.


/// ❌ Using `static` simply because
/// accessing a type property is convenient.
///
/// Static state can become global shared state,
/// which can make testing and dependency
/// management more difficult.


// MARK: - Summary

/*
Struct
────────────────────────────
• Value type.
• Models data and behavior.
• Foundation of SwiftUI.

Initializer
────────────────────────────
• Creates an instance.
• Swift can synthesize memberwise init.
• Custom init is useful for validation
  or custom setup.

Stored Property
────────────────────────────
• Stores actual state.

Computed Property
────────────────────────────
• Calculates a value from existing state.
• Prevents duplicated/derived state.

get / set
────────────────────────────
• Controls reading and writing
  of a computed property.
• Less common than read-only
  computed properties.

willSet
────────────────────────────
• Runs before a value changes.

didSet
────────────────────────────
• Runs after a value changes.

Access Control
────────────────────────────
• Controls API visibility.
• Protects implementation details.
• Important for encapsulation.

private(set)
────────────────────────────
• Public/internal read access.
• Restricted write access.

static
────────────────────────────
• Belongs to the type.
• Useful for constants,
  factories, and type-level behavior.

Rule of Thumb
────────────────────────────
Need a data model?
→ Struct

Value derived from other state?
→ Computed property

Need custom initialization?
→ init

Need to react to a property change?
→ didSet / willSet

Need to protect internal state?
→ private / private(set)

Need type-level behavior or constants?
→ static
*/
