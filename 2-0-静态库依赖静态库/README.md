

静态库.framework 依赖静态库.framework  


静态库 A.framework  
包含对象 Test 方法 -foo  

静态库 B.framework  
包含对象 BObject 方法 -foo_b  
引入静态库 A DoNotEmbed，#import "ALib/Test.h"  
在方法 -foo_b 中调用 A 的 Test-foo 方法。  

静态库 C.framework  
包含对象 Test 方法 -foo，与 A 一样的对象-方法。  

静态库 D.framework  
包含对象 DObject 方法 -foo_d  
引入静态库 C DoNotEmbed，#import "CLib/Test.h"  
在方法 -foo_d 中调用 C 的 Test-foo 方法。  



主工程 app：  
引入静态库库ABCD，Do Not Embed，  
在项目中调用：  
\#import "BLib/BObject.h"  
\#import "DLib/DObject.h"  
[[BObject new] foo_b];  
[[DObject new] foo_d];  
结果是根据 Link Binary With Libraries 中的 AC 顺序而定，谁在前就打印谁的 Test-foo  

对于静态库.framework  
B 中引入静态库 A，查看 B 的可执行文件，并没有包含 A 中的对象，只有在字段  __DATA,__objc_classrefs 中有 _OBJC_CLASS_$_Test  
在 APP 可执行文件中，可看到，BObject DObject Test 对象。  


对于静态库.a （.a 就是 .o 文件的集合）  
如果静态库(可能是 .framework 文件, 也可能是 .a 文件) 里包含 .a 文件，  
查看 Mach-O 文件，可看到 .a 文件里的 .o 文件，所以依赖 .a 文件 build 会吧 .a 文件里的 .o 合并到一起。  







