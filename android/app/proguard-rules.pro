# Razorpay SDK: Keep Razorpay classes and prevent R8 from removing them
-keep class com.razorpay.** { *; }
-dontwarn com.razorpay.**

# Prevent warnings for missing ProGuard annotations
-dontwarn proguard.annotation.Keep
-dontwarn proguard.annotation.KeepClassMembers

# Keep annotations even if they don't exist at runtime
-keep class proguard.annotation.Keep
-keep class proguard.annotation.KeepClassMembers
