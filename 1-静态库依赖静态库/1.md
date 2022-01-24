

静态库.framework 依赖静态库.framework

静态库 A.framework
包含对象 Test 方法 -foo

静态库 B.framework
包含对象 BObject 方法 -foo_b
引入静态库 A Do Not Embed，#import "ALib/Test.h"
在方法 -foo_b 中调用 A 的 Test-foo 方法。

静态库 C.framework
包含对象 Test 方法 -foo



主工程 app：
* 场景一
只引入静态库B C， Do Not Embed
在项目中调用：
\#import "BLib/BObject.h"
\#import "CLib/Test.h"
[[BObject new] foo_b]; //错误。打印的是 C 的 Test-foo
[[Test new] foo]; //正确。打印的是 C 的 Test-foo
打印出的 foo_b 里调用的是 C 的 Test-foo 方法。
错误，预期应该调用 A 的 Test-foo 方法，静态库 B 中没有引入 C，但是打印的是 C 的 Test-foo。


* 场景二
引入静态库ABC，Do Not Embed，Link Binary With Libraries 中的顺序 ABC
和场景一一样，在项目中调用：
\#import "BLib/BObject.h"
\#import "CLib/Test.h"
[[BObject new] foo_b]; //正确。打印的是 A 的 Test-foo
[[Test new] foo]; //错误。打印的是 A 的 Test-foo
如果调整，Link Binary With Libraries 中的顺序 CAB，C 在 A 的前面，那么打印的都是 C 的 Test-foo。




得出的结论：

* 对于静态库.framework
静态库是 .o 的集合，build 时会合并到可执行文件中，引入静态库 Do Not Embed，在 APP 包中没有发现库文件，
查看可执行文件，可看到静态库中的对象，说明静态库是合并到可执行文件里面的。
如果合并的静态库有重复的对象-方法，调用 Link Binary With Libraries 排序在前的那个库的方法。

如果 B 引用 A 使用 A 的对象-方法，A 和 C 有重复的对象-方法，主项目中只引入 B C，则 B 会使用 C 的对象-方法。
即使 C 中没有暴露出与 A 重复的对象-方法，B 也会使用 C 的对象和方法。
猜测是，无论静态库是否暴露出头文件，如果使用到（在其他库使用到也算），合并时都会把使用到的 .o 合并在可执行文件中。
合并时应该先处理引入的库的对象-方法，然后再合并库使用其他库的对象方法，靠前的先使用，也可能后面重复的就不合并。






