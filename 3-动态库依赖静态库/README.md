

动态库依赖静态库   


静态库 A.framework  
包含对象 Test 方法 -foo  

动态库 B.framework  
包含对象 BObject 方法 -foo_b  
引入静态库 A DoNotEmbed，#import "ALib/Test.h"  
在方法 -foo_b 中调用 A 的 Test-foo 方法。  

静态库 C.framework  
包含对象 Test 方法 -foo，与 A 一样的对象-方法。  

动态库 D.framework  
包含对象 DObject 方法 -foo_d  
引入静态库 C DoNotEmbed，#import "CLib/Test.h"  
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

A 中的 .o 会合并到 B 中，C .o 合并到 D 中。主项目中只引入 B D，A C 同名的没有冲突，各调各的。  

B D 嵌入 APP 保重，显示包内容可看到，查看可执行文件，__TEXT,__classname 没看到 B D 中的对象，  
说明动态库，build 不会合并到可执行文件中，运行时才去动态加载相应的动态链接库，加载到内存中。  















