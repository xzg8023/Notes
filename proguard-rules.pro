# Add project specific ProGuard rules here.
# By default, the flags in this file are appended to flags specified
# in F:\AndroidStudio-sdk/tools/proguard/proguard-android.txt
# You can edit the include path and order by changing the proguardFiles
# directive in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# Add any project specific keep options here:

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

-optimizationpasses 5                                                           # 指定代码的压缩级别
-dontusemixedcaseclassnames                                                     # 是否使用大小写混合，不能使用
-dontskipnonpubliclibraryclasses                                                # 是否混淆第三方jar                                                               # 混淆时是否做预校验
-verbose                                                                        # 混淆时是否记录日志
-optimizations !code/simplification/arithmetic,!field/*,!class/merging/*        # 混淆时所采用的算法

# 不做预校验，preverify是proguard的4个功能之一
# android不需要preverify，去掉这一步加快混淆速度
-dontpreverify
-keep public class * extends android.app.Activity                               # 保持哪些类不被混淆
-keep public class * extends android.app.Application                            # 保持哪些类不被混淆
-keep public class * extends android.app.Service                                # 保持哪些类不被混淆
-keep public class * extends android.content.BroadcastReceiver                  # 保持哪些类不被混淆
-keep public class * extends android.content.ContentProvider                    # 保持哪些类不被混淆
-keep public class * extends android.app.backup.BackupAgentHelper               # 保持哪些类不被混淆
-keep public class * extends android.preference.Preference                      # 保持哪些类不被混淆
-keep public class com.android.vending.licensing.ILicensingService              # 保持哪些类不被混淆

-keepclasseswithmembernames class * {                                           # 保持 native 方法不被混淆
    native <methods>;
}

-keepclasseswithmembers class * {                                               # 保持自定义控件类不被混淆
    public <init>(android.content.Context, android.util.AttributeSet);
}

-keepclasseswithmembers class * {
    public <init>(android.content.Context, android.util.AttributeSet, int);     # 保持自定义控件类不被混淆
}

-keepclassmembers class * extends android.app.Activity {                        # 保持自定义控件类不被混淆
   public void *(android.view.View);
}

-keepclassmembers enum * {                                                      # 保持枚举 enum 类不被混淆
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

-keep class * implements android.os.Parcelable {                                # 保持 Parcelable 不被混淆
  public static final android.os.Parcelable$Creator *;
}


-keep class android.support.** { *; }


#保持自定义组件不被混淆
-keep public class * extends android.view.View {
    public <init>(android.content.Context);
    public <init>(android.content.Context, android.util.AttributeSet);
    public <init>(android.content.Context, android.util.AttributeSet, int);
    public void set*(...);
}
#保持 Serializable 不被混淆
-keepnames class * implements java.io.Serializable

#保持 Serializable 不被混淆并且enum 类也不被混淆
-keepclassmembers class * implements java.io.Serializable {
    static final long serialVersionUID;
    private static final java.io.ObjectStreamField[] serialPersistentFields;
    private void writeObject(java.io.ObjectOutputStream);
    private void readObject(java.io.ObjectInputStream);
    java.lang.Object writeReplace();
    java.lang.Object readResolve();
}

#保持枚举 enum 类不被混淆 如果混淆报错，建议直接使用上面的 -keepclassmembers class * implements java.io.Serializable即可
-keepclassmembers enum * {
  public static **[] values();
 public static ** valueOf(java.lang.String);
}


#不混淆资源类
-keepclassmembers class **.R$* {
    public static <fields>;
}

#保持 Parcelable 不被混淆（aidl文件不能去混淆）
-keep class * implements android.os.Parcelable {
    public static final android.os.Parcelable$Creator *;
}
#需要序列化和反序列化的类不能被混淆（注：Java反射用到的类也不能被混淆）
-keepnames class * implements java.io.Serializable

#保护实现接口Serializable的类中，指定规则的类成员不被混淆
-keepclassmembers class * implements java.io.Serializable {
    static final long serialVersionUID;
    private static final java.io.ObjectStreamField[] serialPersistentFields;
    !static !transient <fields>;
    private void writeObject(java.io.ObjectOutputStream);
    private void readObject(java.io.ObjectInputStream);
    java.lang.Object writeReplace();
    java.lang.Object readResolve();
}
#保持R文件不被混淆，否则，你的反射是获取不到资源id的
-keep class **.R$* { *; }

#xUtils(保持注解，及使用注解的Activity不被混淆，不然会影响Activity中你使用注解相关的代码无法使用)
-keep class * extends java.lang.annotation.Annotation {*;}

#类型转换错误 添加如下代码以便过滤泛型（不写可能会出现类型转换错误，一般情况把这个加上就是了）,即避免泛型被混淆
-keepattributes Signature

#抛出异常时保留代码行数
-keepattributes SourceFile,LineNumberTable

# EventBus   假如项目中有用到注解，应加入这行配置,对JSON实体映射也很重要 http://greenrobot.org/eventbus/documentation/proguard
-keepattributes *Annotation*
-keepclassmembers class * {
    @org.greenrobot.eventbus.Subscribe <methods>;
}
-keep enum org.greenrobot.eventbus.ThreadMode { *; }
#EventBus的代码没必要混合
-keep class com.XXX.eventbus.** { *; }
-keep class com.XXX.event.** { *; }
-keep class com.XXX.eventbus.util.** { *; }
-keep class android.os.**{*;}
-keepclassmembers class ** {
    public void onEvent*(**);
}
# Only required if you use AsyncExecutor
-keepclassmembers class * extends org.greenrobot.eventbus.util.ThrowableFailureEvent {
    <init>(java.lang.Throwable);
}

# WebView相关信息不被混淆
# 保护WebView对HTML页面的API不被混淆
-keep class **.Webview2JsInterface { *; }
#如果你的项目中用到了webview的复杂操作,最好加入
-keepclassmembers class * extends android.webkit.WebViewClient {
  public void *(android.webkit.WebView,java.lang.String,android.graphics.Bitmap);
  public boolean *(android.webkit.WebView,java.lang.String);
}
-keepclassmembers class * extends android.webkit.WebChromeClient {
  public void *(android.webkit.WebView,java.lang.String);
}
#三方开源库不用混搅
# RxJava
-keep class rx.** { *; }
-keepclassmembers class rx.** { *; }
-keep enum rx.**
-keepclassmembers enum rx.** { *; }
-keep interface rx.**
-keepclassmembers interface rx.** { *; }



-keep class * extends java.lang.annotation.Annotation {*;}
# Facebook
-keep class com.facebook.** { *; }
# google
-keep class com.google.** { *; }
# Butterknife
-keep class butterknife.** { *; }
# okhttp3    https://github.com/square/okhttp
-keep class okhttp3.** { *; }
-keep class okio.** { *; }
-dontwarn okhttp3.**
-dontwarn okio.**
-dontwarn javax.annotation.**
-dontwarn org.conscrypt.**
# A resource is loaded with a relative path so the package of this class must be preserved.
-keepnames class okhttp3.internal.publicsuffix.PublicSuffixDatabase

#Retrofit2      https://github.com/square/retrofit
-keep class retrofit2.** { *; }

# Retain generic type information for use by reflection by converters and adapters.
-keepattributes Signature
# Retain service method parameters.
-keepclassmembernames,allowobfuscation interface * {
    @retrofit2.http.* <methods>;
}
# Ignore annotation used for build tooling.
-dontwarn org.codehaus.mojo.animal_sniffer.IgnoreJRERequirement

# Lockpattern
-keep class com.start.lockpattern.**{*;}

# ProgressManager    https://github.com/JessYanCoding/ProgressManager,用来显示下载进度的库
-keep class me.jessyan.progressmanager.** { *; }
-keep interface me.jessyan.progressmanager.** { *; }

-keep class com.sun.crypto.provider.**{*;}
-keepclassmembers class com.sun.crypto.provider.** { *; }
-keep enum com.sun.crypto.provider.**
-keepclassmembers enum com.sun.crypto.provider.** { *; }
-keep interface com.sun.crypto.provider.**
-keepclassmembers interface com.sun.crypto.provider.** { *; }


-keep class sun.misc.**{*;}
-keepclassmembers class sun.misc.** { *; }
-keep enum com.sun.crypto.provider.**
-keepclassmembers enum sun.misc.** { *; }
-keep interface sun.misc.**
-keepclassmembers interface sun.misc.** { *; }
-dontwarn sun.misc.**



-keep class com.j256.** {*;}
-keepclassmembers class com.j256.** { *; }
-keep enum com.j256.**
-keepclassmembers enum ** { *; }
-keepclassmembers interface com.j256.** { *; }
-keep interface com.j256.**
-keepclassmembers class * {
@com.j256.ormlite.field.DatabaseField *;
}

-keep class javax.** {*;}
-keepclassmembers class javax.** { *; }
-keep enum javax.**
-keepclassmembers enum ** { *; }
-keepclassmembers interface javax.** { *; }
-keep interface javax.**
-keepclassmembers interface javax.** { *; }
-keepclassmembers enum ** { *; }
-dontwarn   javax.**

-keep class com.sun.** {*;}
-keepclassmembers class com.sun.** { *; }
-keep enum com.sun.**
-keepclassmembers interface com.sun.** { *; }
-keep interface com.sun.**
-keepclassmembers interface com.sun.** { *; }


-keep class sun.** {*;}
-keepclassmembers class sun.** { *; }
-keep enum sun.**
-keepclassmembers interface sun.** { *; }
-keep interface sun.**
-keepclassmembers interface sun.** { *; }

# -keep public class sun.security.internal.interfaces.TlsMasterSecret$*{*;}
-keepclassmembers interface sun.security.internal.interfaces.** { *; }
-dontwarn   sun.security.internal.interfaces.**

-keep class org.slf4j.** {*;}
-dontwarn org.slf4j.**


-keep class sun.security.** {*;}
-dontwarn sun.security.**


-keep class sun.security.** {*;}
-dontwarn sun.security.**

#反编译工具，使用2.1反编译成功 https://github.com/pxb1988/dex2jar/releases
#反编译教程 https://blog.csdn.net/vipzjyno1/article/details/21039349
#混淆文件配置 https://blog.csdn.net/javazejian/article/details/50587857
