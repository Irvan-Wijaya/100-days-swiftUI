import Foundation

// MARK: - Overview
/// **Collections**
/// Collections group multiple values into a single container.
/// Choosing the right collection improves readability, performance, and the overall design of your application.
///
/// Swift provides three primary collection types:
/// - Array         → Ordered collection that allows duplicate values.
/// - Dictionary → Key-value pairs for fast lookups.
/// - Set            → Unordered collection of unique values.

// MARK: 1. Array
/// An Array stores multiple values of the same type in an ordered collection.
///
/// Why:
/// - Preserves insertion order.
/// - Allows duplicate values.
/// - Provides random access by index.
///
/// When:
/// Use an Array whenever the order of elements matters or duplicate values are acceptable.

// Creating Arrays
let fruits = ["Apple", "Banana", "Orange"]

var shoppingCart = [
    "MacBook",
    "Magic Mouse"
]

var recentTransactions: [String] = [] // empty array

// Accessing Elements, Arrays are zero-indexed.
let firstFruit = fruits[0]
let secondFruit = fruits[1]

// Modifying Arrays
/*
shoppingCart.append("Magic Keyboard")
shoppingCart.insert("iPhone", at: 0)
shoppingCart.remove(at: 1)
shoppingCart.removeLast()
shoppingCart.removeAll()
shoppingCart.sort()

// Reading Array Information
shoppingCart.count
shoppingCart.isEmpty
shoppingCart.contains("MacBook")
 
 */

// Type Safety
/// Every element inside an Array must have the same type.
let numbers = [1, 2, 3]
// numbers.append("Four") -> Error

// Type Inference
let scores = [80, 90, 100]
// Inferred as [Int]

let usernames: [String] = []
// var usernames: Array<String> = [] -> They are identical, with [String] simply being a shorter, cleaner shorthand syntax.
// Explicit annotation required because the compiler
// cannot infer the element type.

// Value Type
/// Arrays are value types (structs).
/// They use Copy-on-Write (CoW), meaning the underlying storage
/// is shared until one of the copies is modified.

var original = ["A", "B", "C"]
var copied = original
/*
copied.append("D")
print(original) // ["A", "B", "C"]
print(copied)   // ["A", "B", "C", "D"]

original.withUnsafeBufferPointer { print("Original buffer:", $0.baseAddress!) }
copied.withUnsafeBufferPointer   { print("Copied buffer:  ", $0.baseAddress!) }
-> The result is exactly the same because there haven't been any changes yet.
 
copied.append("D")
copied.withUnsafeBufferPointer   { print("Copied new buffer:    ", $0.baseAddress!) }
-> The result is different because the buffer has just been duplicated (Copy-on-Write was triggered).
 */

// Best Practices
/// Prefer meaningful names.
let employees = ["Alice", "Bob"]

/// Avoid vague names.
let data = ["Alice", "Bob"]

/// Prefer immutable Arrays whenever possible.
let supportedCurrencies = [
    "IDR",
    "USD",
    "JPY"
]

/// Use `var` only when mutation is expected.
var searchHistory: [String] = []

// MARK: 2. Dictionary
/// A Dictionary stores data as key-value pairs rather than using numerical indexes.
///
/// Why:
/// - Lets you decide how to store data, how to look for it, and where it is using meaningful keys.
/// - Provides direct access using meaningful keys instead of numeric indexes. (avoids crashing from reading a non-existent index).
/// - Keys must be unique; setting a value for an existing key overwrites the old value.
///
/// When:
/// Use a Dictionary whenever you want to look up values based on a specific identifier (key) instead of a position (index).

// Creating Dictionaries
/// We specify the Key on the left and the Value on the right, separated by a colon, it is recommended to split them across multiple lines for better readability.
let employee = [
    "name": "Taylor Swift",
    "job": "Singer",
    "location": "Nashville"
]

// Different Data Types
/// You can use various data types for both keys and values.
let hasGraduated = [
    "Eric": false,
    "Maeve": true
] // [String: Bool]

let olympics = [
    2012: "London",
    2016: "Rio de Janeiro",
    2021: "Tokyo"
] // [Int: String]

// Creating Empty Dictionaries
/// You can create an empty dictionary by specifying the explicit Key and Value types.
var heights = [String: Int]() // var heights: [String: Int] = [:] -> same
var archEnemies = [String: String]()

// Modifying Dictionaries
/* You can add elements by assigning a value to a specific key.
heights["Yao Ming"] = 229
heights["Shaquille O'Neal"] = 216
heights["LeBron James"] = 206
 */

/// Dictionaries do not allow duplicate keys.
/* If you set a value for a key that already exists, it will overwrite the old value.
archEnemies["Batman"] = "The Joker"
archEnemies["Superman"] = "Lex Luthor"

archEnemies["Batman"] = "Penguin" // "The Joker" is replaced
 */

// Accessing Elements & Default Values
/// Reading from a dictionary can be tricky because the key might not exist.
/// By default, Swift returns an "Optional" (e.g., Optional("Taylor Swift") or nil).
/// To handle this cleanly and safely, always provide a `default` value.

let employeeName = employee["name", default: "Unknown"]
// Returns "Taylor Swift"

let employeePassword = employee["password", default: "Unknown"]
// Returns "Unknown" because the "password" key does not exist

let londonOlympics = olympics[2012, default: "Unknown"]
// Returns "London"

// Reading Dictionary Information
/// Just like Arrays, Dictionaries come with built-in functionality.
let numberOfHeights = heights.count
// heights.removeAll() // Clears all items in the dictionary

// MARK: 3. Set
/// A Set stores distinct values of the same type in an unordered collection.
///
/// Why:
/// - Guarantees that all elements are unique (no duplicates allowed).
/// - Provides highly optimized, lightning-fast data lookup compared to Arrays.
///
/// When:
/// Use a Set when the order of items doesn't matter, or when you need to ensure that an item only appears once in a collection.

// Creating Sets
/// You can create a Set directly from an Array. Notice that even though we define it with an Array, the Set will discard any duplicates and will NOT remember the original order you typed them in.
let actors = Set([
    "Denzel Washington",
    "Tom Cruise",
    "Nicolas Cage",
    "Samuel L. Jackson"
])
//print(actors) The printed order will be random/different every time.

// Creating an Empty Set & Modifying Elements
var favoriteActors = Set<String>()

/// Unlike Arrays and Dictionaries, an empty Set cannot infer its element type.
// var favoriteActors = Set() -> Error

/// The compiler doesn't know what type of values the Set is supposed to store.
/// Explicit Generic Syntax
// var favoriteActors = Set<String>()

/// Explicit Type Annotation (Preferred)
// var favoriteActors2: Set<String> = []

/// Why?
/// Type inference only works when Swift has enough information.
/// Since an empty Set contains no elements, Swift cannot determine
/// its element type automatically.

/// Instead of `append()`, we use `insert()`. Why? Because `append` implies adding to the "end" of a list. Since Sets have no order, there is no "end" to append to.
/*
favoriteActors.insert("Denzel Washington")
favoriteActors.insert("Tom Cruise")
favoriteActors.insert("Nicolas Cage")
favoriteActors.insert("Samuel L. Jackson")
 */

// The Advantages of Sets
/// 1. Uniqueness
/// Sets inherently prevent duplicates. Like the Screen Actors Guild rule where
/// actors must have unique stage names (e.g., Michael Keaton's real name is
/// Michael Douglas, but he had to change it because the name was taken).

/// 2. Blazing Fast Lookup (Performance)
/// If you use `contains()` on an Array of 1,000 items, Swift has to check from
/// index 0, 1, 2, up to 1,000 one by one.
/// But with a Set, `contains()` runs instantly (0.000001 seconds) whether you have
/// 1,000, 1 million, or 10 million items because Sets store data in a highly optimized way.

let hasTomCruise = favoriteActors.contains("Tom Cruise") // Happens instantly

// Reading Set Information
/// Sets share some common functionality with Arrays and Dictionaries.
let actorCount = favoriteActors.count

/// Since Sets are unordered, calling `sorted()` will take the Set's items,
/// sort them alphabetically (or numerically), and return a sorted **Array**.
let sortedActorsArray = favoriteActors.sorted()

// MARK: - Summary
/*
 Array
 ─────────────────────────────────────────────
 • Ordered collection
 • Allows duplicate values
 • Accessed by index
 • Best when order matters

 Dictionary
 ─────────────────────────────────────────────
 • Key-value pairs
 • Keys must be unique
 • Accessed by key
 • Best for fast lookups using identifiers

 Set
 ─────────────────────────────────────────────
 • Unordered collection
 • Unique values only
 • Very fast membership checks
 • Best when uniqueness is required
*/

// MARK: - Rule of Thumb
/*
Choose the collection based on the problem:

Need ordered data?
→ Array

Need to find values using an identifier?
→ Dictionary

Need unique values with fast membership checks?
→ Set
*/

// MARK: - Additional Knowledge
/// When a dictionary is declared with let, it is immutable. Why not just use `enum` instead?
/// Use an Enum when variants are fixed, finite, and tightly coupled to program logic.
enum UserRole {
    case admin
    case member
    case guest
    
    var accessLevel: Int {
        switch self {
        case .admin: return 1
        case .member: return 2
        case .guest: return 3
        }
    }
}
let level = UserRole.admin.accessLevel // Type-safe, non-optional access with compile-time typo prevention

/// Use an immutable (`let`) Dictionary when:
/// 1. Dataset is too large -> e.g., regional postal codes; writing thousands of enum cases is impractical.
/// 2. Data comes from external sources -> e.g., API payloads, JSON, or database queries.
/// 3. Collection operations are needed -> Dictionaries provide collection APIs like `.count`, `.keys`, and O(1) key lookups.

// Best Practice: Combine both approaches
enum DeviceType {
    case phone
    case tablet
    case desktop
}

// Combines enum type safety with dictionary lookup flexibility
let layoutPadding: [DeviceType: Double] = [
    .phone: 16.0,
    .tablet: 24.0,
    .desktop: 32.0
]

// MARK: - Swift Set-Specific Functions Cheat Sheet
// 1. SET OPERATIONS (Produces a New Set / Mathematical Set Operations)

// A. intersection(_:) -> Elements present in BOTH sets
// Real Case: Finding mutual friends / followers between 2 users
let myFollowers: Set<String> = ["andi", "budi", "citra", "dewi"]
let friendFollowers: Set<String> = ["citra", "dewi", "eka", "fajar"]
let mutualFriends = myFollowers.intersection(friendFollowers) // Output: ["citra", "dewi"] (order in sets is undefined)

// B. union(_:) -> Combines all unique elements from both sets
// Real Case: Merging locally cached tags with freshly fetched tags from an API
let localTags: Set<String> = ["swift", "ios", "uikit"]
let remoteTags: Set<String> = ["swift", "swiftui", "combine"]
let mergedTags = localTags.union(remoteTags) // Output: ["swift", "ios", "uikit", "swiftui", "combine"]

// C. subtracting(_:) -> Elements in Set A that are NOT in Set B
// Real Case: "Select All" feature, excluding disabled/restricted items
let allFeatureIDs: Set<String> = ["camera", "microphone", "bluetooth", "location"]
let restrictedIDs: Set<String> = ["microphone", "location"]
let activeFeatures = allFeatureIDs.subtracting(restrictedIDs) // Output: ["camera", "bluetooth"]

// D. symmetricDifference(_:) -> Elements in either set, but NOT in both
// Real Case: Detecting state divergence between offline checklist and server sync
let localChecklist: Set<String> = ["task1", "task2", "task3"]
let syncedChecklist: Set<String> = ["task2", "task3", "task4"]
let statusDiverged = localChecklist.symmetricDifference(syncedChecklist) // Output: ["task1", "task4"]

// Mutation Note:
// All methods above have in-place mutating variants to avoid new memory allocations:
// formIntersection(_:), formUnion(_:), subtract(_:), formSymmetricDifference(_:)

// 2. SET RELATIONSHIPS (Evaluation of Set Relationships -> Returns Bool)

// A. isSubset(of:) -> Checks if all elements of current set exist in target set
// Real Case: Verifying if user has granted all required permissions for a transaction module
let requiredPermissions: Set<String> = ["biometric", "push_notification"]
let userGrantedPermissions: Set<String> = ["biometric", "push_notification", "camera"]
let canProceed = requiredPermissions.isSubset(of: userGrantedPermissions) // Output: true (all required permissions are granted)

// B. isStrictSubset(of:) -> Same as subset, but must contain strictly fewer elements than the target (cannot be identical)
let basicRoles: Set<String> = ["view", "edit"]
let adminRoles: Set<String> = ["view", "edit", "delete"]
let isStrictMember = basicRoles.isStrictSubset(of: adminRoles) // Output: true (returns false if basicRoles is identical to adminRoles)

// C. isSuperset(of:) -> Checks if current set contains all elements of target set
// Real Case: Verifying if a subscription tier includes all requested features
let premiumPackageFeatures: Set<String> = ["hd_stream", "offline_download", "no_ads"]
let freePackageFeatures: Set<String> = ["hd_stream"]
let hasAccess = premiumPackageFeatures.isSuperset(of: freePackageFeatures) // Output: true

// D. isDisjoint(with:) -> Checks if two sets share NO common elements at all
// Real Case: Schedule validation to ensure room allocation has zero overlap
let assignedClassrooms: Set<String> = ["room_a", "room_b"]
let maintenanceClassrooms: Set<String> = ["room_c", "room_d"]
let isConflictFree = assignedClassrooms.isDisjoint(with: maintenanceClassrooms) // Output: true (no rooms overlap during maintenance)


// 3. SET-SPECIFIC INSERT & UPDATE OPERATIONS

// A. insert(_:) -> Returns tuple (inserted: Bool, memberAfterInsert: Element)
// Real Case: Efficiently preventing duplicate token/request submissions
var processedRequestIDs: Set<String> = ["req_101", "req_102"]
let firstTry = processedRequestIDs.insert("req_103") // Output: (inserted: true, memberAfterInsert: "req_103")
let secondTry = processedRequestIDs.insert("req_101") // Output: (inserted: false, memberAfterInsert: "req_101")

// B. update(with:) -> Inserts new item, or REPLACES existing item if hash/equality matches
// Real Case: Model caching where `id` remains constant, but other fields are refreshed
struct MemberSession: Hashable {
    let id: String
    var lastActive: String
    
    // Hash identity based strictly on `id`
    func hash(into hasher: inout Hasher) { hasher.combine(id) }
    static func == (lhs: MemberSession, rhs: MemberSession) -> Bool { lhs.id == rhs.id }
}

var activeSessions: Set<MemberSession> = [
    MemberSession(id: "usr_01", lastActive: "08:00")
]

// update(with:) overwrites existing instance and returns the old value before replacement
let oldSession = activeSessions.update(with: MemberSession(id: "usr_01", lastActive: "09:30"))
// Output oldSession: Optional(MemberSession(id: "usr_01", lastActive: "08:00"))
// activeSessions now contains the updated session with lastActive "09:30"
