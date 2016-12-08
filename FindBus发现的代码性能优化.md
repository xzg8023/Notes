##### FindBus发现的代码性能优化

+ Boxing/unboxing to parse a primitive

> A boxed primitive is created from a String, just to extract the unboxed primitive value. It is more efficient to just call the static parseXXX method.

```java
    Integer.valueOf(str) //更换前
    Integer.parseInt(str)  //更换后
```
        查看源码会发现Integer.valueOf(...)会调用Integer.parseInt(..)，其它类型转换方法类似。
        
+ Method invokes inefficient Number constructor; use static valueOf instead

> **valueOf instead**

> Using new Integer(int) is guaranteed to always result in a new object whereas Integer.valueOf(int) allows caching of values to be done by the compiler, class library, or JVM. Using of cached values avoids object allocation and the code will be faster.
>
Values between -128 and 127 are guaranteed to have corresponding cached instances and using valueOf is approximately 3.5 times faster than using constructor. For values outside the constant range the performance of both styles is the same.
>
Unless the class must be compatible with JVMs predating Java 1.5, use either autoboxing or the valueOf() method when creating instances of Long, Integer, Short, Character, and Byte.

```java
    Integer integer = new Integer(value);   //更换前
    Integer integer = Integer.valueOf(value);  //更换后
```
+ Method invokes inefficient Boolean constructor; use Boolean.valueOf(...) instead
>Creating new instances of java.lang.Boolean wastes memory, since Boolean objects are immutable and there are only two useful values of this type.  Use the Boolean.valueOf() method (or Java 1.5 autoboxing) to create Boolean objects instead.

```java
    	Boolean bool = new Boolean(value); //更换前
        Boolean bool = Boolean.valueOf( value );   //更换后
	
```

+ Method invokes inefficient new String() constructor
>Creating a new java.lang.String object using the no-argument constructor wastes memory because the object so created will be functionally indistinguishable from the empty string constant "".  Java guarantees that identical string constants will be represented by the same String object.  Therefore, you should just use the empty string constant directly.

```java
    String str = new String();   //更换前
	String str = "";         //更换后
``` 

+ Method concatenates strings using + in a loop

>The method seems to be building a String using concatenation in a loop. In each iteration, the String is converted to a StringBuffer/StringBuilder, appended to, and converted back to a String. This can lead to a cost quadratic in the number of iterations, as the growing string is recopied in each iteration.

>Better performance can be obtained by using a StringBuffer (or StringBuilder in Java 1.5) explicitly.

>For example:

```java
  // This is bad
  String s = "";
  for (int i = 0; i < field.length; ++i) {
    s = s + field[i];
  }

  // This is better
  StringBuffer buf = new StringBuffer();
  for (int i = 0; i < field.length; ++i) {
    buf.append(field[i]);
  }
  String s = buf.toString();
```

+ Inefficient use of keySet iterator instead of entrySet iterator

>This method accesses the value of a Map entry, using a key that was retrieved from a keySet iterator. It is more efficient to use an iterator on the entrySet of the map, to avoid the Map.get(key) lookup.

```java
//修改前
//        Set<Calendar> set = map.keySet();
//        if(set!=null && !set.isEmpty()){
//            for (Calendar calendar: set){
//                TitleEvent event=map.get(calendar);
//                titleList.add(event);
//            }
//        }

        
 //修改后       
        Iterator<Calendar> iterator = map.keySet().iterator();
        if (iterator != null ){
            while (iterator.hasNext()){
                Calendar calendar = iterator.next();
                TitleEvent event=map.get(calendar);
                titleList.add(event);
            }
        }

```

+ Should be a static inner class

>This class is an inner class, but does not use its embedded reference to the object which created it.  This reference makes the instances of the class larger, and may keep the reference to the creator object alive longer than necessary.  If possible, the class should be made static.

```java
public class ListAdapter extends BaseAdapter {

    ....
    
    private class ViewHolder {
		ImageView	imgView;
		TextView	textTitle;

	}
}
```
