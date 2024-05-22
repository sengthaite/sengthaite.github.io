---
title: My Note Kotlin
layout: content
duration: 36mn
tags: kotlin
--- 

## Default imports package

1. kotlin.*
2. kotlin.annotation.*
3. kotlin.collections.*
4. kotlin.comparisons.*
5. kotlin.io.*
6. kotlin.ranges.*
7. kotlin.sequences.*
8. kotlin.text.*

## Basic Type

1. Number: Byte (8), Short (16), Int (32), Long (64)
2. Boolean: true, false
3. Character: Char
4. String: raw string, escaped string, string template ($)
5. Array

## Type checks and casts

1. **is** and **!is** operators
2. **as**

## Control flow

1. **If** expression
2. **When** expression
3. **For loops**
4. **While loops**

> There is no ternary operator in kotlin

```kotlin
// Similar expression
val max = if (a > b) a else b
```

```kotlin
// when is used as alternative to switch case in c
val x = 1
when(x) {
    1 -> println("x = 1")
    else -> {
        println("Default case")
    }
}
```

```kotlin
val someVal = 1
when (someVal) {
    0, 1 -> println("is bit")
    else -> println("is not bit")
}
```

```kotlin
val someVal = 1
when (someVal) {
    in 0..9 -> println("in range 0 -> 9")
    else -> println("default")
}
```

```kotlin
// when can also be used as a replacement for an if-else if chain
fun Int.isOdd() = this % 2 != 0

val x: Int = 9
when {
x.isOdd() -> print("x is odd")
else -> print("x is not odd")
}
```

```kotlin
for (item in collection) print(item)
```

```kotlin
for (item: Int in ints) {
    println(item)
}
```

```kotlin
// for loop in range
for (i in 0..3) {
    println(i)
}
```

```kotlin
for ((key, value) in array.withIndex()) {
    println("key: $key, value: $value")
}
```

```kotlin
// goto like
label@ for (i in 0..100) {
    for (j in 0..60) {
        if (j == 10) break@label
        println("j: $j")
    }
}
```

```kotlin
listOf(1, 2, 3, 4, 5).forEach {
    if (it == 3) return // non-local return directly to the caller of foo()
    print(it)
}

listOf(1, 2, 3, 4, 5).forEach lit@{
    if (it == 3) return@lit // local return to the caller of the lambda - the forEach loop
    print(it)
}

listOf(1, 2, 3, 4, 5).forEach {
    if (it == 3) return@forEach // local return to the caller of the lambda - the forEach loop
    print(it)
}

listOf(1, 2, 3, 4, 5).forEach(fun(value: Int) {
    if (value == 3) return  // local return to the caller of the anonymous function - the forEach loop
    print(value)
})

run loop@{
    listOf(1, 2, 3, 4, 5).forEach {
        if (it == 3) return@loop // non-local return from the lambda passed to run
        print(it)
    }
}

print(run loop@{
    return@loop 20
})
```

## Exceptions

```kotlin
try {
    ...
} catch (e: SomeException) {
    // handler
} finally {
    // optional finally block
}
```

> The throw expression has the type Nothing. This type has no values and is used to mark code locations that can never be reached.

```kotlin
val name = person.name ?: throw IllegalArgumentException("Name required")

fun fail(message: String): Nothing {
    throw IllegalArgumentException(message)
}

val s = person.name ?: fail("Name required")

val x = null           // 'x' has type `Nothing?`
val l = listOf(null)   // 'l' has type `List<Nothing?>
```

> Function parameters are defined using Pascal notation - name: type. Parameters are separated using commas, and each parameter must be explicitly typed

```kotlin
fun powerOf(number: Int, exponent: Int): Int { /*...*/ }
```

```kotlin
// trailing comma
fun powerOf(
    number: Int,
    exponent: Int, // trailing comma
) { /*...*/ }
```

```kotlin
// default value arguments
fun read(
    b: ByteArray,
    off: Int = 0,
    len: Int = b.size,
) { /*...*/ }
```

```kotlin
fun foo(
    bar: Int = 0,
    baz: Int = 1,
    qux: () -> Unit,
) { /*...*/ }

foo(1) { println("hello") }     // Uses the default value baz = 1
foo(qux = { println("hello") }) // Uses both default values bar = 0 and baz = 1
foo { println("hello") }        // Uses both default values bar = 0 and baz = 1

```

```kotlin
// If a function does not return a useful value, its return type is Unit. Unit is a type with only one value - Unit. This value does not have to be returned explicitly

fun printHello(name: String?): Unit {
    if (name != null)
        println("Hello $name")
    else
        println("Hi there!")
    // `return Unit` or `return` is optional
}
```

## Variable number of arguments (varargs)

```kotlin
fun <T> asList(vararg ts: T): List<T> {
    val result = ArrayList<T>()
    for (t in ts) // ts is an Array
        result.add(t)
    return result
}
```

## Infix notation

Some requirements:
1. must be member functions or extension functions
2. must have single parameter
3. not accept variable arguments and no default value

```kotlin
infix fun Int.add(x: Int): Int = this + x

fun main() {
    print(2.add(2))
    print(10 add 2)
}
```

```kotlin
class MyStringCollection {
    infix fun add(s: String) { /*...*/ }

    fun build() {
        this add "abc"   // Correct
        add("abc")       // Correct
        //add "abc"        // Incorrect: the receiver must be specified
    }
}
```

## Local function

> Local function : functions inside other functions

```kotlin
fun util() {
    fun printSomeString(): Unit = println("Hello, World")
    
    printSomeString()
}

fun main() {
    util()
}
```

> Member function : a function that is defined inside a class or object

```kotlin
class SomeName {
    fun someFun() = println("Print this message.")
}
```

## Tail recursion

```kotlin
val eps = 1E-10 // "good enough", could be 10^-15

tailrec fun findFixPoint(x: Double = 1.0): Double =
    if (Math.abs(x - Math.cos(x)) < eps) x else findFixPoint(Math.cos(x))
```

## High-order function

> High-order function: a function that takes functions as parameters, or returns a function

```kotlin
fun <T, R> Collection<T>.fold(
    initial: R,
    combine: (acc: R, nextElement: T) -> R
): R {
    var accumulator: R = initial
    for (element: T in this) {
        accumulator = combine(accumulator, element)
    }
    return accumulator
}

val items = listOf(1, 2, 3, 4, 5)

// Lambdas are code blocks enclosed in curly braces.
items.fold(0, { 
    // When a lambda has parameters, they go first, followed by '->'
    acc: Int, i: Int -> 
    print("acc = $acc, i = $i, ") 
    val result = acc + i
    println("result = $result")
    // The last expression in a lambda is considered the return value:
    result
})

// Parameter types in a lambda are optional if they can be inferred:
val joinedToString = items.fold("Elements:", { acc, i -> acc + " " + i })

// Function references can also be used for higher-order function calls:
val product = items.fold(1, Int::times)
```

## Function type

Function type special notation:

1. All function types have a paranthesized list of **parameter types** and a **return type**.
2. Optionally have an additional *receiver type* which is specified before the dot in the notation: the type A.(B) -> C
3. Suspending functions
4. Function type alternative name type alias:

```kotlin
typealias ClickHandler = (Button, ClickEvent) -> Unit
```

## Class construction

> class has 2 constructors: **primary** and **secondary** constructor.

```kotlin
const val mText = "Browser"

fun main() {
    println("Hello, world!!!")
    
    val emptyObj = EmptyClass()
    println(emptyObj)
    
    val person = Person("John", "Brain")
    println(person.fullName())
    println("Uppercase first name : ${person.upperFirstName}")
    
    println("$mText")
    
    val newObject = NewObject("One two three", 10)
    newObject.addOne()
    
    val parent = Human("Yaki")
    
    val currentChild = Human("Miki", parent)
    parent.printChildren()
    
    val testClass = InitRunningClass(1)
}

// class with no body
class EmptyClass

// class with primary constructor
class Person public constructor(firstName: String, lastName: String?) {
    
    val fName: String 
    val lName: String?
    
    val upperFirstName = firstName.uppercase()
    
    init {
        fName = firstName
        lName = lastName
        println("First init running.")
    }
    
    init {
        println("Another init running.")
    }
    
    fun fullName() = fName + " " + (lName ?: "") 
}

class NewObject(param: String, var mutableVar: Int) {
    
    init {
        println("Param value: $param")
    }
    
    fun addOne() {
        mutableVar += 1
        println("After add one: $mutableVar")
    }
}

// class with secondary constructor
class Human(val name: String) {
    val children: MutableList<Human> = mutableListOf()
    
    constructor(name: String, parent: Human) : this(name) {
        parent.children.add(this)
    }
    
    fun printChildren() {
        for (child in children) {
            println("child name: " + child.name)
        }
    }
}

class TestingConstructor(firstParam: String) {
    init {
        println("Initialization $firstParam")
    }
    init {
        println("initialization 1")
    }
    init {
        println("initialization 2")
    }
    init {
        println("initialization 3")
    }
    /*
    // Conflicting overload error
    constructor(param: String): this(param) {
        println("error constructor")
    }
    constructor(firstParam: String) {
        println("")
    }
    constructor(firstParam: String): this(firstParam) {
        println("")
    }
    */
    
    constructor(firstParam: String, secondParam: String): this(firstParam) {
        println("secondary constructor with param: $secondParam")
    }
    
    /*
    // Conflicting overload error
    constructor(firstParam: String, otherParam: String): this(firstParam) {
        println("secondary constructor with param: $otherParam")
    }
    */
    
    constructor(firstParam: String, secondParam: String, thirdParam: String): this(firstParam) {
        println("another secondary constructor with param: $firstParam, $secondParam, $thirdParam")
    }
    
}
```

## Class abstract

```kotlin
fun main() {
    val circle = Circle()
    circle.draw()
    
    val inheritFromSomething = InheritFromSomething()
    inheritFromSomething.saySomething()
}

abstract class Shape {
    abstract fun draw()
}

class Circle: Shape() {
    override fun draw() {
        println("drawing")
    }
}

open class Something {
    open fun sayHello() {
        println("Hello!")
    }
}

abstract class AbstractFromSomething: Something() {
    abstract override fun sayHello()
}

class InheritFromSomething: AbstractFromSomething() {
    override fun sayHello() {
        println("Hi")
    }
    fun saySomething() {
        sayHello()
    }
}
```

## Visibility modifiers (4) 

1. **private**: the member is visible inside this class only
2. **protected**: the member has the same visibility as one marked as private, but that it is also visible in subclasses
3. **internal**: any client inside this module who sees the declaring class sees its internal members
4. **public**: any client who sees the declaring class sees its public members

```kotlin
fun main() {
    PublicClass()
    PrivateClass()
    InternalClass() 
    //ProtectedClass()
}

public class PublicClass {}
private class PrivateClass {}
internal class InternalClass {}
/*
// Modifier 'protected' is not applicable inside 'file'
protected class ProtectedClass {}
*/
```

## Inheritance

> class and function by default is final means cannot be inherited. Use open keyword to allow inheritance.

> abstract class is always **open**.

> If the derived class has a primary constructor, the base class can (and must) be initialized in that primary constructor according to its parameters.

```kotlin
open class Base(p: Int)

class Derived(p: Int) : Base(p)
```

## Type aliases

> Type aliases provide alternative names for existing types

```kotlin
typealias MyHandler = (Int, String, Any) -> Unit
```

```kotlin
class A {
    inner class Inner
}
class B {
    inner class Inner
}

typealias AInner = A.Inner
typealias BInner = B.Inner
```

## Different between *abstract class* and *interface*

> **abstract class** can do what interface can do and more. It can have **constructor**, **init body**, and **fields** so we can properly hold state.

```kotlin
abstract class Person(_name: String) {
   var name: String
   abstract var age: Int 
   
   // Initializer Block
   init {
      this.name = _name
   }
   
   abstract fun setPersonAge(_age:Int) // abstract
   abstract fun getPersonAge():Int // abstract
   
   fun getPersonName(){ // non-abstract
       println("Name = $name")
   }
}
```

```kotlin
open class Rectangle {
    open fun draw() { /* ... */ }
}

interface Polygon {
    fun draw() { /* ... */ } // interface members are 'open' by default
}

class Square() : Rectangle(), Polygon {
    // The compiler requires draw() to be overridden:
    override fun draw() {
        super<Rectangle>.draw() // call to Rectangle.draw()
        super<Polygon>.draw() // call to Polygon.draw()
    }
}
```

```kotlin
// Interface inheritance

interface Named {
    val name: String
}

interface Person : Named {
    val firstName: String
    val lastName: String

    override val name: String get() = "$firstName $lastName"
}

data class Employee(
    // implementing 'name' is not required
    override val firstName: String,
    override val lastName: String,
    val position: Position
) : Person

```

```kotlin
// Resolving overriding conflicts

interface A {
    fun foo() { print("A") }
    fun bar()
}

interface B {
    fun foo() { print("B") }
    fun bar() { print("bar") }
}

class C : A {
    override fun bar() { print("bar") }
}

class D : A, B {
    override fun foo() {
        super<A>.foo()
        super<B>.foo()
    }

    override fun bar() {
        super<B>.bar()
    }
}
```

```kotlin
// function interface or Single Abstract Method (SAM): can have several non-abstract members but only one abstract member

fun interface IntPredicate {
   fun accept(i: Int): Boolean
}

val isEven = IntPredicate { it % 2 == 0 } // lambda expression

fun main() {
   println("Is 7 even? - ${isEven.accept(7)}")
}
```

```kotlin
// rewrite with typealias

typealias IntPredicate = (i: Int) -> Boolean

val isEven: IntPredicate = { it % 2 == 0 }

fun main() {
   println("Is 7 even? - ${isEven(7)}")
}
```

## Property

> **Property**: **var** (mutable), **val** (read-only)

> **Getter and Setter**

```kotlin
class Rectangle(val width: Double, val height: Double) {
    private var _description: String? = null
    val area get() = this.width * this.height
    
    var name: String = "My Rect"
    	private set // disable set to the value without changing the default implementation
    
    var description: String
    	get() = this._description ?: "Area: $area, name: $name"
    	set(newValue) {
            this._description = newValue
        }
}
```

> **Compile-time constant (const)**: read-only property cannot use with **var**

```kotlin
const val someConstant = "Text"
// const val someConstant = "Text" // Modifier 'const' is not applicable to 'vars'

fun main() {
    // const val newConstant = "Text" // Modifier 'const' is not applicable to 'vars'
}
```

> **lateinit**: properties can be initialized through dependency injection, or in the setup method of a unit test. To check whether a lateinit var has already been initialized, use .isInitialized.

```kotlin
public class MyTest {
    lateinit var subject: TestSubject

    @SetUp fun setup() {
        subject = TestSubject()
    }

    @Test fun test() {
        subject.method()  // dereference directly
    }
}
```

## Delegate property

```kotlin
import kotlin.reflect.KProperty

class Delegate {
    operator fun getValue(thisRef: Any?, property: KProperty<*>): String {
        return "$thisRef, thank you for delegating '${property.name}' to me!"
    }

    operator fun setValue(thisRef: Any?, property: KProperty<*>, value: String) {
        println("$value has been assigned to '${property.name}' in $thisRef.")
    }
}

class Example {
    var p: String by Delegate()
}

fun main() {
    val example = Example()
    println(example.p)
}
```

**Kind of property**: 

1. Lazy properties: the value is computed only on the first access

```kotlin
/*
lazy() is a function that takes a lambda and returns an instance of Lazy<T>, which can serve as a delegate for implementing a lazy property
*/

val lazyValue: String by lazy {
    println("computed!")
    "Hello"
}

fun main() {
    println(lazyValue)
    println(lazyValue)
}
```

2. Observable properties: listeners are notified about changes to this property

```kotlin
import kotlin.properties.Delegates

class User {
    var name: String by Delegates.observable("<no name>") {
        prop, old, new ->
        println("$old -> $new")
    }
}

fun main() {
    val user = User()
    user.name = "first"
    user.name = "second"
}
```

3. Storing properties  in a map instead of a separate field for each property

```kotlin
class User(val map: Map<String, Any?>) {
    val name: String by map
    val age: Int     by map
}

fun main() {
   val user = User(mapOf(
        "name" to "John Doe",
        "age"  to 25
   ))
   var anotherUser = User(mapOf(
       "name" to "MacOS"
   ))
   println("Name: ${user.name}")
   println("Another user's name: ${anotherUser.name}")
}
```

## Delegating to another property

> Useful when annotate the old property with @Deprecated annotation

```kotlin
class MyClass {
   var newName: Int = 0
   @Deprecated("Use 'newName' instead", ReplaceWith("newName"))
   var oldName: Int by this::newName
}

fun main() {
   val myClass = MyClass()
   // Notification: 'oldName: Int' is deprecated.
   // Use 'newName' instead
   myClass.oldName = 42
   println(myClass.newName) // 42
}
```

## Local delegate property

```kotlin
class SomeType {
    fun doSomething() {
        println("Do something!")
    }
}

fun getSomeType(): SomeType {
    return SomeType()
}

fun example(computeFoo: () -> SomeType) {
    val memoizedFoo by lazy(computeFoo)

    if (true) { // if false the memoizedFoo is not initialized
        memoizedFoo.doSomething()
    }
}

fun main() {
    example(::getSomeType)
}
```

## Property delegate requirements

```kotlin
class Resource

class Owner {
    var varResource: Resource by ResourceDelegate()
}

class ResourceDelegate(private var resource: Resource = Resource()) {
    operator fun getValue(thisRef: Owner, property: KProperty<*>): Resource {
        return resource
    }
    operator fun setValue(thisRef: Owner, property: KProperty<*>, value: Any?) {
        if (value is Resource) {
            resource = value
        }
    }
}

// create delegates as anonymous objects without creating new classes, by using the interfaces ReadOnlyProperty and ReadWriteProperty from the Kotlin standard library.
fun resourceDelegate(resource: Resource = Resource()): ReadWriteProperty<Any?, Resource> =
    object : ReadWriteProperty<Any?, Resource> {
        var curValue = resource
        override fun getValue(thisRef: Any?, property: KProperty<*>): Resource = curValue
        override fun setValue(thisRef: Any?, property: KProperty<*>, value: Resource) {
            curValue = value
        }
    }

val readOnlyResource: Resource by resourceDelegate()  // ReadWriteProperty as val
var readWriteResource: Resource by resourceDelegate()
```

## Translation rules for delegated properties

```kotlin 
class C {
    var prop: Type by MyDelegate()
}

// this code is generated by the compiler instead:
class C {
    private val prop$delegate = MyDelegate()
    var prop: Type
        get() = prop$delegate.getValue(this, this::prop)
        set(value: Type) = prop$delegate.setValue(this, this::prop, value)
}
```

**Optimized cases for delegated properties**:

1. A referenced property

```kotlin
class C<Type> {
    private var impl: Type = ...
    var prop: Type by ::impl
}
```

2. A named object

```kotlin
object NamedObject {
    operator fun getValue(thisRef: Any?, property: KProperty<*>): String = ...
}

val s: String by NamedObject
```

3. A final val property with a backing field and a default getter in the same module

```kotlin
val impl: ReadOnlyProperty<Any?, String> = ...

class A {
    val s: String by impl
}
```

4. A constant expression, enum entry, this, null. The example of this

```kotlin
class A {
    operator fun getValue(thisRef: Any?, property: KProperty<*>) ...

    val s by this
}
```

## Extension

```kotlin
// add swap functionality to MutableList of type Int
fun MutableList<Int>.swap(firstIndex: Int, secondIndex: Int) {
    val tmp = this[firstIndex]
    this[firstIndex] = this[secondIndex]
    this[secondIndex] = tmp
}

fun main() {
    val list: MutableList<Int> = mutableListOf(10 , 2)
    list.swap(0, 1)
    print("Swapped List: $list")
}
```

> By defining an extension, you are not inserting new members into a class, only making new functions callable with the dot-notation on variables of this type.

```kotlin
// Extension functions are dispatched statically, which means they are not virtual by receiver type.

open class Shape
class Rectangle: Shape()

fun Shape.getName() = "Shape"
fun Rectangle.getName() = "Rectangle"

fun printClassName(s: Shape) {
    println(s.getName())
}

printClassName(Rectangle())
// this will print "Shape"
```

> If a class has a member function, and an extension function is defined which has the same receiver type, the same name, and is applicable to given arguments, **the member always wins**.

```kotlin
class Example {
    fun printFunctionType() { println("Class method") }
}

fun Example.printFunctionType() { println("Extension function") }

Example().printFunctionType()
// this will print "Class method"
```

```kotlin
class Example {
    fun printFunctionType() { println("Class method") }
}

fun Example.printFunctionType(i: Int) { println("Extension function #$i") }

Example().printFunctionType(1)
// this will print "Extension function #1"
```

```kotlin
// Nullable receiver extension of type Any
fun Any?.toString(): String {
    if (this == null) return "null"
    // after the null check, 'this' is autocast to a non-null type, so the toString() below
    // resolves to the member function of the Any class
    return toString()
}
```

```kotlin
// Extension on properties
val <T> List<T>.lastIndex: Int
    get() = size - 1

fun main() {
    val list: List<Int> = listOf(1, 2, 4)
    println(list.lastIndex)
}
```

```kotlin
// Companion object extension
class MyClass {
    companion object { }  // will be called "Companion"
}

fun MyClass.Companion.printCompanion() { println("companion") }

fun main() {
    MyClass.printCompanion()
}
```

```kotlin
// To use extension out of package scope import it
///////////////////////////
package org.example.declarations

fun List<String>.getLongestString() { /*...*/}
///////////////////////////
package org.example.usage

import org.example.declarations.getLongestString

fun main() {
    val list = listOf("red", "green", "blue")
    list.getLongestString()
}
///////////////////////////
```

```kotlin
// Declaration extension as member
class Host(val hostname: String) {
    fun printHostname() { print(hostname) }
}

class Connection(val host: Host, val port: Int) {
    fun printPort() { print(port) }

    fun Host.printConnectionString() {
        printHostname()   // calls Host.printHostname()
        print(":")
        printPort()   // calls Connection.printPort()
    }

    fun connect() {
        /*...*/
        host.printConnectionString()   // calls the extension function
    }
}

fun main() {
    // Connection instance is dispatch receiver. Host instance is extension receiver
    Connection(Host("kotl.in"), 443).connect()
    //Host("kotl.in").printConnectionString()  // error, the extension function is unavailable outside Connection
}
```

```kotlin
// In the event of a name conflict between the members of a dispatch receiver and an extension receiver, the extension receiver takes precedence.
class Connection {
    fun Host.getConnectionString() {
        toString()         // calls Host.toString()
        this@Connection.toString()  // calls Connection.toString()
    }
}
```

## Data class

> Main purpose: to hold data.

**Requirements of data class**:

1. Primary constructor must have **at least one parameter**.
2. All primary constructors need to be marked as **var / val**
3. Data class cannot be **abstract**, **open**, **sealed**, or **inner**. 

> For properties declared inside data class primary constructor will implement: 

1. equals() / hashCode() pair
2. toString()
3. componentN()
4. copy()

```kotlin
// Use copy() to copy the object with the param allow alteration
data class Human(val name: String, var age: Int, val family: String)

fun main() {
    val father = Human("John Mark", 50, "John")
    val child = father.copy(name = "John Mimi", age = 12)
    println(father)
    println(child1)
}
```

```kotlin
// Data class and destructuring declaration
data class Human(val name: String, var age: Int, val family: String)

fun main() {
    val father = Human("John Mark", 50, "John")
    val (age, name) = father // destructuring declaration
    println("My name is $name age $age.")
}
```

## Enum classes

> The most basic use case for enum classes is the implementation of type-safe enums.
> Each enum constant is an object.

```kotlin
enum class Direction {
    NORTH, SOUTH, WEST, EAST
}

enum class Color(val rgb: Int) {
    RED(0xFF0000),
    GREEN(0x00FF00),
    BLUE(0x0000FF)
}
```

```kotlin
// Anonymous class
enum class ProtocolState {
    WAITING {
        override fun signal() = TALKING
    },

    TALKING {
        override fun signal() = WAITING
    };

    abstract fun signal(): ProtocolState
}

fun main() {
    print(ProtocolState.WAITING.signal())
}
```

> An enum class can implement an interface (but it cannot derive from a class), providing either a common implementation of interface members for all the entries, or separate implementations for each entry within its anonymous class.

```kotlin
import java.util.function.BinaryOperator
import java.util.function.IntBinaryOperator


enum class IntArithmetics : BinaryOperator<Int>, IntBinaryOperator {
    PLUS {
        override fun apply(t: Int, u: Int): Int = t + u
    },
    TIMES {
        override fun apply(t: Int, u: Int): Int = t * u
    };
    
    override fun applyAsInt(t: Int, u: Int) = apply(t, u)
}


fun main() {
    val a = 13
    val b = 31
    for (f in IntArithmetics.values()) {
        println("$f($a, $b) = ${f.apply(a, b)}")
    }
}
```

```kotlin
enum class RGB { RED, GREEN, BLUE }

inline fun <reified T : Enum<T>> printAllValues() {
    print(enumValues<T>().joinToString { it.name })
}

fun main() {
    printAllValues<RGB>() // prints RED, GREEN, BLUE
}
```

```kotlin
// Every enum constant has properties:
val name: String
val ordinal: Int
```

## Sealed classes

> **Sealed classes and interfaces** represent restricted class hierarchies that provide more control over inheritance.
> **Sealed classes** prevent subclassing outside of the module that sealed appeared (once a module with a sealed interface is compiled, no new implementations can appear.).
> **Sealed class** is similar to **enum class** but enum class only has single instance while sealed class can has multiple instances, each with its own state.
> **Constructors of sealed classes** can have one of two visibilities: **protected (by default)** or **private**.
> **Sealed class** is abstract class (cannot be instantiated).
> **enum classes** can't extend a sealed class (as well as any other class), but they can implement sealed interfaces.

```kotlin
// Declaring sealed class and interface
sealed interface Error

sealed class IOError(): Error

class FileReadError(val file: File): IOError()
class DatabaseError(val source: DataSource): IOError()

object RuntimeError : Error
```

```kotlin
// No public modifer in sealed class
sealed class IOError {
    constructor() { /*...*/ } // protected by default
    private constructor(description: String): this() { /*...*/ } // private is OK
    // public constructor(code: Int): this() {} // Error: public and internal are not allowed
}
```

```kotlin
// Sealed class and when expression
fun log(e: Error) = when(e) {
    is FileReadError -> { println("Error while reading file ${e.file}") }
    is DatabaseError -> { println("Error while reading from database ${e.source}") }
    is RuntimeError ->  { println("Runtime error") }
    // the `else` clause is not required because all the cases are covered
    // still required when using in multiplatform
}
```

## Inline class

> Wrapper around primitive type introduces runtime overhead so kotlin provide *inline class*.

```kotlin
value class Password(private val s: String)

// No actual instantiation of class 'Password' happens
// At runtime 'securePassword' contains just 'String'
val securePassword = Password("Don't try this in production")
```

> Inline classes support some functionality of regular classes. In particular, they are allowed to declare properties and functions, and have the init block.
> Inline class properties cannot have backing fields. They can only have simple computable properties (no lateinit/delegated properties).
> Inline classes are allowed to inherit from interfaces.
> It is forbidden for inline classes to participate in a class hierarchy. This means that inline classes cannot extend other classes and are always final.
> Inline classes can also have a generic type parameter as the underlying type. Generic inline classes is an Experimental feature. It may be dropped or changed at any time. Opt-in is required with the -language-version 1.8 compiler option.
> Inline classes introduce a truly new type, contrary to type aliases which only introduce an alternative name (alias) for an existing type.
> Implementation by delegation to inlined value of inlined class is allowed with interfaces.

```kotlin
interface MyInterface {
    fun bar()
    fun foo() = "foo"
}

@JvmInline
value class MyInterfaceWrapper(val myInterface: MyInterface) : MyInterface by myInterface

fun main() {
    val my = MyInterfaceWrapper(object : MyInterface {
        override fun bar() {
            // body
        }
    })
    println(my.foo()) // prints "foo"
}
```

## Nested and inner classes

```kotlin
interface OuterInterface {
    class InnerClass
    interface InnerInterface
}

class OuterClass {
    class InnerClass
    interface InnerInterface
}
```

```kotlin
// A nested class marked as inner can access the members of its outer class.
class Outer {
    private val bar: Int = 1
    inner class Inner {
        fun foo() = bar
    }
}

val demo = Outer().Inner().foo() // == 1
```

```kotlin
// Anonymous inner classes
window.addMouseListener(object : MouseAdapter() {

    override fun mouseClicked(e: MouseEvent) { ... }

    override fun mouseEntered(e: MouseEvent) { ... }
})
```

## Generic: in, out, and where

```kotlin
class Box<T>(t: T) {
    var value = t
}

fun main() {
    val box: Box<Int> = Box<Int>(1)
    val anotherBox = Box(2)
    println("Box: $box")
    println("Another box: $anotherBox")
}
```