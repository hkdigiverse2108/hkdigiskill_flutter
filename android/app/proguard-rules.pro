# --- Razorpay and Google Pay missing classes handling ---

# Don't warn or fail when these classes are missing (they are part of GPay, optional for device)
-dontwarn com.google.android.apps.nbu.paisa.inapp.client.api.**

# Keep Razorpay classes (repeat from before, essential!)
-keep class com.razorpay.** { *; }

# Don't warn about (non-existent) annotation classes
-dontwarn proguard.annotation.Keep
-dontwarn proguard.annotation.KeepClassMembers
-keep class proguard.annotation.Keep { *; }
-keep class proguard.annotation.KeepClassMembers { *; }

# Keep attributes for annotation usage
-keepattributes *Annotation*
