// MARK: Classes in Swift

/// ## Overview
/// A Swift `class` is a custom reference type that can encapsulate:
/// - stored and computed properties
/// - instance and type methods
/// - initializers
/// - inheritance
/// - overriding
/// - deinitialization
/// - reference identity
///
/// The most important distinction between `class` and `struct` is not syntax. It is **semantics**:
///
/// - `struct` → value semantics
/// - `class` → reference semantics
///
/// This distinction affects:
/// - how state is shared
/// - how mutations propagate
/// - how objects are compared
/// - how object lifetime is managed
/// - how application architecture should be designed
///
/// SwiftUI uses structs heavily, while UIKit/Foundation contain many class-based APIs.
/// Understanding classes is therefore important for both Swift fundamentals and professional iOS development.


// MARK: - 1. The Mental Model: Value vs Reference
/// ## Struct = "This value"
/// A struct represents a value. Assigning a struct creates an independent value.

struct ValueUser {
    var name: String
}

var valueUser1 = ValueUser(name: "Taylor")
var valueUser2 = valueUser1
valueUser2.name = "John"

print(valueUser1.name) // Taylor
print(valueUser2.name) // John

/// Conceptually:
///
///     valueUser1 ──> User("Taylor")
///     valueUser2 ──> User("Taylor")
///
///     Change valueUser2
///             ↓
///     valueUser1 ──> User("Taylor")
///     valueUser2 ──> User("John")
///
/// The key idea:
///
///     Assigning a value type gives you an independent value.
///
/// This is one reason structs are predictable and excellent for data models.

// MARK: - 2. Classes = Shared Reference to the Same Instance
/// A class behaves differently. Assignment does not create another independent object.  Instead, both variables can refer to the same class instance.

final class ReferenceUser {
    var name: String

    init(name: String) {
        self.name = name
    }
}

let referenceUser1 = ReferenceUser(name: "Taylor")
let referenceUser2 = referenceUser1
referenceUser2.name = "John"

print(referenceUser1.name) // John
print(referenceUser2.name) // John

/// Why did changing `referenceUser2` also change `referenceUser1`?
///
/// Because:
///
///     let referenceUser2 = referenceUser1
///
/// does not create another `ReferenceUser`. Both variables refer to the same instance.
///
///     referenceUser1 ─────┐
///                         ▼
///                   ┌──────────────┐
///                   │ ReferenceUser│
///                   │ name = John  │
///                   └──────────────┘
///                         ▲
///                         │
///     referenceUser2 ─────┘
///
/// This is **reference semantics**.


// MARK: - 3. Identity
/// A class instance has identity.
///
/// Consider:
///
///     let accountA = BankAccount(id: "ACC-001")
///     let accountB = accountA
///
/// `accountA` and `accountB` are two references to the same object.
///
/// Swift therefore provides identity operators:
///
///     accountA === accountB
///
/// `===` asks:
///
///     "Are these references pointing to the exact same class instance?"
///
/// This is different from:
///
///     accountA == accountB
///
/// which asks whether two values are considered equal.
///
/// Important distinction:
///
/// - `==` → equality
/// - `===` → identity

final class BankAccount {
    let id: String

    init(id: String) {
        self.id = id
    }
}

let accountA = BankAccount(id: "ACC-001")
let accountB = accountA
print(accountA === accountB) // true


// MARK: - 4. Why Would We Want Reference Semantics?
/// The important engineering question is not:
///
///     "Can I use a class?"
///
/// The better question is:
///
///     "Do I need shared identity or shared mutable state?"
///
/// Reference semantics are useful when multiple parts of the application should
/// observe or modify the same logical instance.
///
/// Typical characteristics:
///
/// - object identity matters
/// - state is shared
/// - lifecycle matters
/// - the object owns resources or work
/// - inheritance is required
/// - a framework/API requires reference semantics
///
/// Example:
///
///     Login Scene ──────┐
///                       │
///     Home Scene ───────┼──> SessionManager
///                       │
///     Profile Scene ────┘
///
/// All components can intentionally interact with the same session object.

// MARK: - 5. Basic Class Syntax
/// A class can contain the same fundamental building blocks you already saw with structs:
/// - properties
/// - methods
/// - initializers
/// - access control
/// - static members
///
/// What changes is the semantic model: classes are reference types.

final class Person {
    let name: String
    var age: Int

    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }

    func introduce() {
        print("I'm \(name)")
    }
}

let person = Person(name: "Taylor", age: 24)
person.introduce()


// MARK: - 6. `let` on a Class Does NOT Make the Object Immutable | Essentials
/// This is one of the most important differences between a class and a struct.
/// For a class:
///
///     let user = User(...)
///
/// makes the **reference** constant.
/// It does NOT automatically make the object's mutable properties immutable.
/// Example:

final class MutableUser {
    var name: String

    init(name: String) {
        self.name = name
    }
}

let mutableUser = MutableUser(name: "Taylor")
mutableUser.name = "John" // Valid

/// But this is not valid:
///
///     mutableUser = MutableUser(name: "Alex")
///
/// because the `let` reference cannot be redirected.
///
/// Conceptually:
///
///     let mutableUser
///             │
///             └── The arrow cannot be redirected.
///
///                 ┌─────────────────┐
///                 │ MutableUser     │
///                 │ name = Taylor   │
///                 └─────────────────┘
///
/// Contrast this with a struct:
///
///     struct User {
///         var name: String
///     }
///
///     let user = User(name: "Taylor")
///     user.name = "John" // Error
///
/// Rule:
/// - `struct` + `let` → the value cannot be mutated
/// - `class` + `let` → the reference cannot be redirected

// MARK: - 7. When Should You Use a Class?
/// Start with this engineering heuristic:
///
///     Use a class when the object has meaningful identity
///     or intentional shared mutable state.
///
/// Ask these questions:
/// 1. Does the object need identity?
///    Examples:
///    - a specific UIViewController
///    - a specific coordinator
///    - a specific session
///    - a specific long-lived service instance
///
/// 2. Should multiple components share one mutable instance?
///    Example:
///
///         Feature A ─┐
///         Feature B ─┼──> SessionManager
///         Feature C ─┘
///
/// 3. Does the object have a meaningful lifecycle?
///    Classes support `deinit`, which matters for objects that own or manage resources.
///
/// 4. Is inheritance genuinely required?
///    Swift classes support inheritance and overriding.

// MARK: - 8. When Should You NOT Use a Class?

/// A common beginner mistake is:
///
///     "Classes are more powerful, so I should use classes for everything."
///
/// That is not a sound design rule, If a type primarily represents data, a struct is usually a better starting point.
/// Example:

struct Transaction {
    let id: String
    let amount: Decimal
    let date: Date
}

/// A transaction usually represents a **value**, not a long-lived shared object  with independently managed identity.
/// This means:
/// - no shared mutable identity is normally required
/// - no inheritance is normally required
/// - no custom object lifecycle is normally required
///
/// Rule of thumb:
///
///     Start with a struct. Move to a class when you have a concrete reason.
///
/// Possible reasons:
/// - identity
/// - shared mutable state
/// - lifecycle
/// - inheritance
/// - UIKit/Foundation/API requirements

// MARK: - 9. Real iOS Example: Transaction Model
/// Banking transaction data is a strong candidate for a struct.
///
///     Transaction
///         ↓
///     data/value
///
/// It can be:
/// - decoded from an API
/// - passed between layers
/// - rendered by views
/// - transformed into another representation
///
/// You normally do not need a transaction object to own a lifecycle or coordinate other objects.

// MARK: - 10. Real iOS Example: Session Manager
/// Authentication/session state is a different problem.
/// Multiple parts of the application may need to interact with the same session state. That makes reference semantics useful.

final class SessionManager {
    private(set) var accessToken: String?

    var isLoggedIn: Bool {
        accessToken != nil
    }

    func login(with token: String) {
        accessToken = token
    }

    func logout() {
        accessToken = nil
    }
}

let sessionManager = SessionManager()
sessionManager.login(with: "token-123")

print(sessionManager.isLoggedIn) // true
print(sessionManager.accessToken ?? "No token")

sessionManager.logout()
print(sessionManager.isLoggedIn) // false

/// The important point is not that "SessionManager must be a class".
/// The important point is:
///
///     Multiple components may intentionally participate
///     in the state of the same session instance.
///
/// That is reference semantics doing useful architectural work.

// MARK: - 11. Class Inheritance
/// One major capability classes have that structs do not is inheritance. A class can inherit behavior and stored/computed properties from a superclass.
/// Conceptually:
///
///     PaymentService
///           │
///           └── CardPaymentService

class PaymentService {
    func process() {
        print("Processing payment")
    }
}

final class CardPaymentService: PaymentService {
    func validateCard() {
        print("Validating card")
    }
}

let cardPaymentService = CardPaymentService()
cardPaymentService.process()
cardPaymentService.validateCard()

// MARK: - 12. Overriding
/// A subclass can specialize inherited behavior using `override`.

class BasePaymentService {
    func process() {
        print("Generic payment")
    }
}

final class SpecializedCardPaymentService: BasePaymentService {
    override func process() {
        print("Processing card payment")
    }
}

let specializedService = SpecializedCardPaymentService()
specializedService.process()

/// `override` communicates explicit intent:
///
///     "This implementation already exists in a superclass,
///      and I intentionally want to replace it for this subtype."
///
/// The compiler can then validate that the override is legitimate.

// MARK: - 13. `final`
/// `final` prevents a class from being subclassed.
/// Example:

final class NetworkClient {
    // ...
}

/// You can also prevent a specific method from being overridden:
class BaseService {
    final func authenticate() {
        print("Authenticating")
    }
}

/// Engineering perspective:
/// `final` communicates:
///
///     "This abstraction is not designed to be extended
///      through inheritance."
///
/// This is useful for many application-level types:
/// - services
/// - managers
/// - repositories
/// - use-case objects
/// - infrastructure components
///
/// Many classes do not actually need subclassing. Making that explicit reduces accidental inheritance.

// MARK: - 14. Inheritance Is Powerful, But Do Not Default to It
/// Inheritance creates a strong dependency:
///
///     Subclass
///        ↓
///     Superclass behavior
///
/// If the superclass changes, subclasses may also be affected.
///
/// This can create:
/// - tight coupling
/// - fragile base classes
/// - difficult testing
/// - unexpected inherited behavior
///
/// Before writing:
///
///     class Child: Parent
///
/// ask:
///
///     "Do I genuinely need subtype polymorphism and inherited behavior?"
///
/// If not, composition or protocols may be more appropriate.

// MARK: - 15. Composition vs Inheritance

/// Inheritance often represents:
///
///     "A is a B"
///
/// Example:
///
///     Car is a Vehicle
///
/// Composition represents:
///
///     "A has a B"
///
/// Example:
///
///     CheckoutCoordinator has a PaymentService
///
/// Composition often reduces coupling.
///
/// Example:

protocol PaymentServiceProtocol {
    func process()
}

final class CardPaymentServiceV2: PaymentServiceProtocol {
    func process() {
        print("Card payment")
    }
}

final class CheckoutCoordinator {
    private let paymentService: PaymentServiceProtocol

    init(paymentService: PaymentServiceProtocol) {
        self.paymentService = paymentService
    }

    func startPayment() {
        paymentService.process()
    }
}

let checkoutCoordinator = CheckoutCoordinator(
    paymentService: CardPaymentServiceV2()
)

checkoutCoordinator.startPayment()

/// This design makes the coordinator depend on a capability
/// rather than a concrete superclass.
///
/// Benefits include:
///
/// - explicit dependencies
/// - easier testing
/// - lower coupling
/// - better substitution of implementations
///
/// Protocols will be explored more deeply later, but the principle is already useful:
///
///     Class does not automatically mean inheritance.


// MARK: - 16. Deinitialization

/// Classes can define a `deinit`.
///
/// `deinit` runs when the class instance is about to be deallocated.
/// You do not call it manually.

final class FileHandler {
    init() {
        print("FileHandler created")
    }

    deinit {
        print("FileHandler destroyed")
    }
}

func demonstrateDeinitialization() {
    let handler = FileHandler()
    print(handler)
}

demonstrateDeinitialization()

/// After the function scope ends, the local strong reference disappears.
/// If no other strong references exist, the object can be deallocated
/// and `deinit` can run.


// MARK: - 17. ARC: The Lifecycle Behind Classes

/// Swift uses Automatic Reference Counting (ARC) for class instances.
///
/// Simplified mental model:
///
///     Number of strong references
///                 ↓
///     determines whether the object can remain alive.
///
/// Example:

final class UserSessionObject {
    let id: String

    init(id: String) {
        self.id = id
    }
}

var session1: UserSessionObject? = UserSessionObject(id: "SESSION-001")

var session2 = session1

session1 = nil

print(session2?.id ?? "No session")

session2 = nil

/// Conceptually:
///
///     session1 ──────┐
///                    ├──> UserSessionObject
///     session2 ──────┘
///
/// After:
///
///     session1 = nil
///
/// only `session2` remains.
///
/// When:
///
///     session2 = nil
///
/// no strong references remain, so the object can be deallocated.


// MARK: - 18. Why ARC Matters to an iOS Engineer

/// You normally do not manually manage retain/release operations in Swift.
///
/// But you must still understand ownership.
///
/// This becomes critical with:
///
/// - closures
/// - delegates
/// - timers
/// - view controllers
/// - networking
/// - coordinators
/// - subscriptions
/// - long-lived services
///
/// A major issue is a **retain cycle**.
///
/// Conceptually:
///
///     Object A
///        │
///        │ strong
///        ▼
///     Object B
///        │
///        │ strong
///        ▼
///     Object A
///
/// Neither object can be released because each one keeps the other alive.


// MARK: - 19. Strong vs Weak

/// By default, a class reference is strong.
///
/// A strong reference keeps the referenced instance alive.
///
/// A weak reference does not own the instance.
///
/// Example:

protocol CoordinatorDelegate: AnyObject {
    func didFinish()
}

final class ChildCoordinator {
    weak var delegate: CoordinatorDelegate?
}

/// This type of relationship is common in UIKit and coordinator-based architectures.
///
/// The deeper rule is not:
///
///     "Delegates are always weak."
///
/// The better rule is:
///
///     "Use weak ownership when the relationship should not
///      keep the referenced object alive."
///
/// `weak` is especially important when two objects would otherwise
/// strongly retain each other.


// MARK: - 20. Reference Semantics and Function Calls

/// Classes are reference types inside function calls as well.
///
/// A function receives access to the same object instance.

final class RenameableUser {
    var name: String

    init(name: String) {
        self.name = name
    }
}

func rename(_ user: RenameableUser) {
    user.name = "John"
}

let renameableUser = RenameableUser(name: "Taylor")

rename(renameableUser)

print(renameableUser.name) // John

/// The function did not receive an independent copy of the object.
/// It operated on the same class instance.
///
/// This is useful for intentional shared state,
/// but dangerous when mutation is accidental.


// MARK: - 21. The Real Risk of Classes: Hidden Shared Mutation

/// Consider:

final class Cart {
    var items: [String] = []
}

let cartA = Cart()
let cartB = cartA

cartB.items.append("Laptop")

print(cartA.items) // ["Laptop"]

/// The mutation happened through `cartB`,
/// but `cartA` observes it because both references point to the same instance.
///
/// This leads to an important architectural principle:
///
///     Shared mutable state is powerful when intentional,
///     but dangerous when accidental.
///
/// Value semantics often make state transitions easier to reason about:
///
///     old value → new value
///
/// Reference semantics can create:
///
///     many references → one mutable object
///
/// The latter requires stronger ownership and mutation discipline.


// MARK: - 22. SwiftUI Connection

/// SwiftUI uses structs heavily:
///
///     struct LoginView: View {
///         var body: some View {
///             Text("Login")
///         }
///     }
///
/// This is intentional.
///
/// A SwiftUI `View` is a value describing UI.
///
/// SwiftUI can create and recreate view values as application state changes.
///
/// Compare:
///
///     SwiftUI View
///         ↓
///     value describing UI
///
/// versus:
///
///     UIViewController
///         ↓
///     identity + lifecycle + object state
///
/// Understanding classes therefore helps explain why SwiftUI
/// and UIKit can feel architecturally different.


// MARK: - 23. Professional iOS Examples

/// ## Usually struct
///
/// Data/value-oriented models:
///
///     struct Transaction { ... }
///     struct UserProfile { ... }
///     struct APIResponse { ... }
///
/// Why?
///
/// They primarily represent values.
///
/// ## Often class
///
/// Types such as:
///
///     final class SessionManager { ... }
///     final class LoginViewModel { ... }
///     final class TransferCoordinator { ... }
///     final class NetworkClient { ... }
///
/// may be classes when identity, state, lifecycle,
/// coordination, or dependencies matter.
///
/// Important:
///
/// These names do NOT automatically imply that the type must be a class.
/// Architecture should determine the semantics.


// MARK: - 24. Banking App Example

/// Imagine a transfer flow.
///
/// Data model:

struct TransferRequest {
    let sourceAccountID: String
    let destinationAccountID: String
    let amount: Decimal
}

/// A transfer request is naturally a value.
///
/// It can be:
/// - created
/// - passed to another layer
/// - encoded for networking
/// - copied safely
/// - transformed
///
/// There is normally no need for shared object identity.


/// A coordinator may have lifecycle and ownership responsibilities:

final class TransferCoordinator {
    private let transferService: TransferServiceProtocol

    init(transferService: TransferServiceProtocol) {
        self.transferService = transferService
    }

    func startTransfer(_ request: TransferRequest) {
        print("Starting transfer:", request.amount)
        transferService.submit(request)
    }
}

/// The coordinator is a stronger candidate for a class because
/// its identity and lifetime represent an ongoing navigation/feature flow.


/// A service can also be instantiated and injected:

protocol TransferServiceProtocol {
    func submit(_ request: TransferRequest)
}

final class TransferService: TransferServiceProtocol {
    func submit(_ request: TransferRequest) {
        print("Submitting transfer:", request.amount)
    }
}

let transferService = TransferService()

let transferCoordinator = TransferCoordinator(
    transferService: transferService
)

let transferRequest = TransferRequest(
    sourceAccountID: "SOURCE-001",
    destinationAccountID: "DEST-001",
    amount: 100_000
)

transferCoordinator.startTransfer(transferRequest)

/// Notice that the service is injected.
///
/// This is usually easier to test and reason about than hiding it
/// behind an implicit global singleton.


// MARK: - 25. Architecture Rule

/// When modeling a type, ask:

///     Is this primarily DATA?
///             │
///             └── Yes → Prefer struct
///
///     Is this a unique ENTITY with identity?
///             │
///             └── Yes → Consider class
///
///     Does it need SHARED MUTABLE STATE?
///             │
///             └── Yes → Consider class
///
///     Does it have a meaningful LIFECYCLE?
///             │
///             └── Yes → Consider class
///
///     Does it require INHERITANCE?
///             │
///             └── Yes → class
///
///     None of the above?
///             │
///             └── Start with struct

/// This is a better decision process than:
///
///     "Use classes for objects and structs for simple data."
///
/// The real issue is semantics, ownership, and behavior.


// MARK: - 26. Class vs Struct

/// +----------------------+-----------------------------+-----------------------------+
/// | Concern              | Struct                      | Class                       |
/// +----------------------+-----------------------------+-----------------------------+
/// | Semantics            | Value type                 | Reference type              |
/// | Assignment           | Independent value          | Same instance referenced    |
/// | Identity             | No object identity         | Has identity                |
/// | Shared mutation      | Less implicit              | Natural                     |
/// | Inheritance          | No                         | Yes                         |
/// | Override             | No                         | Yes                         |
/// | `deinit`             | No                         | Yes                         |
/// | ARC                  | Not for the struct itself  | Yes                         |
/// | `let` instance        | Cannot mutate stored state | Can mutate `var` properties |
/// | Default starting fit | Usually yes                | When semantics require it   |
/// +----------------------+-----------------------------+-----------------------------+
///
/// Keep the table as a mental model rather than a checklist of syntax.


// MARK: - 27. Common Mistakes

/// ## Mistake 1 — Using classes everywhere
///
/// Classes are not "better" than structs.
/// They provide different semantics.
///
/// Choose based on ownership, identity, lifecycle, and behavior.


/// ## Mistake 2 — Thinking assignment creates a copy
///
/// For a class:
///
///     let b = a
///
/// usually means:
///
///     b refers to the same instance as a
///
/// It does not mean:
///
///     create a new independent object

/// ## Mistake 3 — Thinking `let` makes a class immutable
///
/// This can be valid:
///
///     let user = User(...)
///     user.name = "John"
///
/// because `let` protects the reference,
/// not necessarily the object's internal mutable state.


/// ## Mistake 4 — Using inheritance by default
///
/// Inheritance creates coupling.
/// Prefer composition or protocols when inheritance is not actually needed.


/// ## Mistake 5 — Ignoring object lifetime
///
/// A class can stay alive longer than expected because another object,
/// closure, timer, subscription, or owner still strongly references it.
///
/// This is a real production concern in iOS.


/// ## Mistake 6 — Using singleton/shared state only for convenience
///
/// Example:
///
///     final class AppManager {
///         static let shared = AppManager()
///     }
///
/// This is convenient:
///
///     AppManager.shared
///
/// But global shared state can introduce:
///
/// - hidden dependencies
/// - difficult tests
/// - unclear ownership
/// - unexpected coupling
///
/// The syntax is easy.
/// The architecture is the difficult part.


// MARK: - 28. Decision Checklist

/// Before creating a class, ask:
///
/// ## Identity
///
/// Does this represent a specific object whose identity matters?
///
/// ## Sharing
///
/// Should different parts of the application reference
/// and mutate the same instance?
///
/// ## Lifecycle
///
/// Does the object own work/resources and have a meaningful lifetime?
///
/// ## Inheritance
///
/// Is subclassing genuinely required?
///
/// ## Framework constraint
///
/// Does the framework/API require a class?
///
/// ## Mutability
///
/// Would reference-based mutation make the architecture clearer,
/// or would it create hidden shared state?
///
/// If most answers are "no", start with a struct.


// MARK: - 29. Engineer Perspective

/// The difference between classes and structs is really about
/// **how you want state to behave**.
///
///
/// VALUE SEMANTICS
/// ----------------
/// State is copied
///     ↓
/// Local reasoning
///     ↓
/// Fewer accidental side effects
///
///
/// REFERENCE SEMANTICS
/// ------------------
/// State is shared
///     ↓
/// Object identity
///     ↓
/// Useful collaboration
///     ↓
/// Greater mutation and lifetime complexity
///
/// Therefore:
///
///     Choosing a class means choosing reference semantics,
///     identity, shared state, and ownership/lifecycle behavior.
///
/// It is not simply another syntax for a data model.


// MARK: - 30. Summary

/// ## Class
///
/// - Reference type
/// - Assignment shares the same instance
/// - Has identity
/// - Supports inheritance
/// - Supports overriding
/// - Supports deinitialization
/// - Managed by ARC
/// - Useful for shared mutable state and lifecycle-heavy objects
///
/// ## Struct
///
/// - Value type
/// - Assignment creates an independent value
/// - No object identity
/// - No inheritance
/// - Excellent for data models
/// - Usually easier to reason about
///
/// ## `===`
///
/// Checks whether two references point to the exact same class instance.
///
/// ## `final`
///
/// Prevents subclassing or overriding.
///
/// ## `deinit`
///
/// Runs when a class instance is about to be deallocated.
///
/// ## ARC
///
/// Tracks strong references to class instances and manages their lifetime.


// MARK: - 31. Rule of Thumb

/// Need to model a VALUE?
/// → struct
///
/// Need object IDENTITY?
/// → consider class
///
/// Need SHARED MUTABLE STATE?
/// → consider class
///
/// Need object LIFECYCLE / ownership?
/// → consider class
///
/// Need INHERITANCE?
/// → class
///
/// No strong reason for reference semantics?
/// → Start with struct.


// MARK: - 32. One-Sentence Mental Model

/// Structs are usually about what something IS as a value;
/// classes are about a particular thing EXISTING as an identity
/// that can be shared, mutated, and managed over time.
