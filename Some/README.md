## some关键字 

以下是打开新建`SwiftUI`项目的默认代码。

```swift
import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, World!")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
```

`ContentView`遵循`View`协议，`View`协议要求一个名为`body`类型为`some View`的计算属性。你可能会疑问`some`关键字的作用？

### some关键字的含义？

`some`关键字在`Swift 5.1版本`中被引入，定义为一个**不透明类型**。不透明类型被称为反向泛型，通过例子来理解不透明类型。我们先来理解泛型。

#### 泛型

泛型基本上就是占位符，当你想要声明函数支持多种类型时你可以使用泛型。最好的例子就是`max`函数，返回输入的2个参数的较大值，类型为不知道的T。

```swift
func max<T>(_ x: T, _ y: T) -> T
```
声明语句接受两个类型相同的输入参数，类型未知。由于未知类型我们不能获取更多的信息，导致无法编写函数的具体内容。那就是为什么我们在不知道实际类型的情况下需要使用协议来约束泛型类型，可以使我们获取更多关于类型T的性质。
```swift
func max<T>(_ x: T, _ y: T) -> T where T: Comparable
```
`Comparable`协议需要类型必须实现比较运算符: 
```swift
public protocol Comparable : Equatable {
   static func < (lhs: Self, rhs: Self) -> Bool
   // ...
}
```
`Comparable`是我们这个函数的泛型约束，尽管我们不知道T的具体类型但是我们已经知道我们可以运用运算符来比较T的两个实例，因此我们可以实现 *max* 函数。
```swift
func max<T>(_ x: T, _y: T) -> T where T: Comparable {
    if y > x {
        return y
    } else {
        return x
    }
}
```
泛型隐藏了函数实现中值的实际类型，从外部调用函数你总是知道参数类型和函数返回类型。


#### 不透明类型

不透明类型是相反的，外部调用者不知道函数的返回类型，内部知道要处理的类型。
为了简单起见，我们定义一个牛奶的协议，品牌属性是关联类型。定义伊利、蒙牛、光明三种遵循协议的结构体。
```swift
protocol Milk {
    associatedtype BrandType
    var brand: BrandType { get }
    // ...
}

struct Yili: Milk {
    var brand: Int
}

struct MengNiu: Milk {
    var brand: Double
}

struct GuangMing: Milk {
    var brand: String
}
```
我们每日的牛奶来自这3种品牌的一种，但我们不知道是哪种。编写一个选牛奶的错误，返回
```swift
func pickerRandomMilk() -> Milk  // 💥 Error
// protocol can only be used as a generic constraint because it has Self or associated type requirements
```
Swift不允许我们使用具有关联类型的协议作为返回类型。我们无法推断关联类型是什么，无法确定返回类型是什么。我们需要加上some关键字将特定类型转化为不透明类型。
```swift
func pickerRandomMilk() -> Milk   // ✅ Compiles
```
加上关键字返回一个不透明类型，意味着编译器和你知道会返回一个特定的具体类型，但永远不知道是什么。
对于不透明类型，是一种让编译器根据返回值来决定返回的具体类型方法。

## 参考文章
[What's some?](https://medium.com/@PhiJay/whats-this-some-in-swiftui-34e2c126d4c4)