

动态库依赖动态库  


动态库 A.framework  
包含对象 Test 方法 -foo  

动态库 B.framework  
包含对象 BObject 方法 -foo_b  
引入静态库 A Embed，#import "ALib/Test.h"  
在方法 -foo_b 中调用 A 的 Test-foo 方法。  

动态库 C.framework  
包含对象 Test 方法 -foo，与 A 一样的对象-方法。  

动态库 D.framework  
包含对象 DObject 方法 -foo_d  
引入静态库 C Embed，#import "CLib/Test.h"  
在方法 -foo_d 中调用 C 的 Test-foo 方法。  



主工程 app：  
* 场景一  
只引入动态库B D， Embed&Sgin  
在项目中调用：  
\#import "BLib/BObject.h"  
\#import "DLib/DObject.h"  
[[BObject new] foo_b]; //正确。打印的是 A 的 Test-foo  
[[DObject new] foo_d]; //正确。打印的是 C 的 Test-foo  

打印时有提示，  
objc[81317]: Class Test is implemented in both  
One of the two will be used. Which one is undefined.  

B 依赖 动态库 A，是嵌入在 B 中，没有合并到 B 的可执行文件中。运行时才去动态连接加载到内存中调用。  
B D 能各自动态连接到对应的方法，正确调用没有影响。  















