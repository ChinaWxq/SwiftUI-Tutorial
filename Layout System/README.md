## 布局系统

### 基本布局

#### 布局过程

1. 父视图建议子视图大小。RootView提供一个除Safe Area的屏幕尺寸给子视图，依次传递。
2. 子视图选择自身大小。子视图具有自身大小选择权，固定尺寸或者适应父视图。
3. 父视图处理子视图位置。根据子视图大小，再向上反馈调整父视图大小。

#### 演示


首先，你需要忘记所有从UIkit或AppKit中了解的frame。那些与SwiftUI中的frame没有任何联系。

我们首先在SwiftUI中展示一个64x64的`Image`，看看給它设置80x80的frame会发生什么？

```swift
struct LayoutDemo: View {
    var body: some View {
        Image("icon") // 60 * 60
            .border(Color.red)
            .frame(width: 80, height: 80)
            .border(Color.blue)
    }
}
```
<p align="center">
<img src="/Resources/layout1.png">
</p>

image并没有发生改变。为什么？因为`frame`在SwiftUI并不是一个约束，也不是view的bounds或者frame属性。在SwiftUI中`frame`是另一个视图。调用`Image("icon").frame(width: 80, height: 80)`，SwiftUI创建一个指定大小的不可见的视图容器，包含一个图片视图。布局过程如之前的步骤，新容器视图`frame`建议子视图大小80x80，Image视图反映只需要60x60。`frame`视图需要把图片放置在某个位置，子视图默认放置在中间--默认使用`.center`作为alignment属性。

在SwiftUI中除非你对Image标记`resizable()`，否则它会按照自身实际大小显示。如果标记，frame大小可以影响到image的大小。

```swift
struct LayoutDemo: View {
    var body: some View {
        Image("icon") // 60 * 60
            .resizable()
            .border(Color.red)
            .frame(width: 80, height: 80)
            .border(Color.blue)
    }
}
```
<p align="center">
<img src="/Resources/layout2.png">
</p>

最后我们看看，如果frame大小小于子视图的大小会发生什么？

```swift
struct LayoutDemo: View {
    var body: some View {
        Image("icon") // 60 * 60
            .border(Color.red)
            .frame(width: 40, height: 80)
            .border(Color.blue)
    }
}
```

<p align="center">
<img src="/Resources/layout3.png">
</p>

子视图最终会决定自己的大小，这是理解SwiftUI布局系统十分重要的一点。

### 堆栈布局过程

1. 计算内部边距，并从父视图建议的尺寸中减去内边距。
2. 堆栈将剩余空间分成剩余视图的相等部分，扣除最不灵活子视图的尺寸，然后重复。
3. 按照堆栈间距和对齐方式排列子视图。

#### 演示

```swift
struct StackLayout: View {
    var body: some View {
        HStack(spacing: 10) {
            Image("icon")
                .border(Color.red)
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent et ipsum nulla. In nec nisl nunc. Nulla lectus sem, vulputate non dolor nec, tristique pulvinar felis.")
                            .border(Color.green)
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit.")
                            .border(Color.blue)
        }
    }
}

struct StackLayout_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StackLayout()
                .previewLayout(.fixed(width: 230, height: 120))
            StackLayout()
                .previewLayout(.fixed(width: 340, height: 180))
        }
    }
}
```

<p align="center">
<img src="/Resources/layout4.png">
</p>

在第一个预览中宽度是230。
1. 首先减去内边距，减去2x10的内边距 230 - 2 x 10 = 210。
2. 堆栈从剩余尺寸减去image的尺寸尺寸60x60，210 - 60 = 150.
3. 均分剩下尺寸每个部分65x65，第一个Text接受到的建议尺寸是65x120，但是文本无法完全显示，可以展示一部分内容，第二个文本也会出现同样的问题。

在第二个预览中宽度是340。为堆栈提供了更多的空间，第二个文本适合了，堆栈总是将未分配的空间分成相等的部分，第二个文本占据了所有的空间。

## 参考
[SwiftUI Layout System](https://kean.blog/post/swiftui-layout-system#stack-layout-process)