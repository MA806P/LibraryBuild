

静态库依赖动态库  


动态库 A.framework  
包含对象 Test 方法 -foo  

静态库 B.framework  
包含对象 BObject 方法 -foo_b  
引入静态库 A Embed，#import "ALib/Test.h"  
在方法 -foo_b 中调用 A 的 Test-foo 方法。  

动态库 C.framework  
包含对象 Test 方法 -foo，与 A 一样的对象-方法。  

静态库 D.framework  
包含对象 DObject 方法 -foo_d  
引入静态库 C Embed，#import "CLib/Test.h"  
在方法 -foo_d 中调用 C 的 Test-foo 方法。  



主工程 app：  
* 场景一  
只引入静态库B D， Do Not Embed  
在项目中调用：  
\#import "BLib/BObject.h"  
\#import "DLib/DObject.h"  
[[BObject new] foo_b]; //正确。打印的是 A 的 Test-foo  
[[DObject new] foo_d]; //错误。打印的是 A 的 Test-foo，期望是 C 的 Test-foo  

按理说，静态库 B D 中不包含动态库 A C，在主项目中又没引入动态库 A C，  
那么主项目调用 B D，是怎么找到 A 中的 Test-foo 方法的呢？  


* 场景二  
引入静态库BD Do Not Embed，动态库 AC Embed&Sign  
和场景一一样，在项目中调用：  
\#import "BLib/BObject.h"  
\#import "DLib/DObject.h"  
[[BObject new] foo_b];  
[[DObject new] foo_d];  
结果是根据 Link Binary With Libraries 中的 AC 顺序而定，谁在前就打印谁的 Test-foo。  


objc[78971]: Class Test is implemented in both 。。。   
One of the two will be used. Which one is undefined.  

静态库依赖动态库  
A C 为动态库，APP 可执行文件中，不包含 Test。只包含静态库 B D 中的代码  
上面的都是静态库的话，可执行文件中包含了 Test。  









