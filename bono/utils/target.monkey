Strict

#BONO_ANDROID_MARKET="google"
#If Not (BONO_ANDROID_MARKET="google") And Not (BONO_ANDROID_MARKET="amazon")
#Error "Invalid BONO_ANDROID_MARKET setting - must be 'google' or 'amazon'"
#End

Class Target Abstract

#If BONO_ANDROID_MARKET="google"
    Const IS_MARKET_GOOGLE:Bool = True
#Else
    Const IS_MARKET_GOOGLE:Bool = False
#End

#If BONO_ANDROID_MARKET="amazon"
    Const IS_MARKET_AMAZON:Bool = True
#Else
    Const IS_MARKET_AMAZON:Bool = False
#End

#If TARGET="android"
    Const IS_ANDROID:Bool = True
#Else
    Const IS_ANDROID:Bool = False
#End

#If TARGET="flash"
    Const IS_FLASH:Bool = True
#Else
    Const IS_FLASH:Bool = False
#End

#If TARGET="glfw"
    Const IS_GLFW:Bool = True
#Else
    Const IS_GLFW:Bool = False
#End

#If TARGET="html4"
    Const IS_HTML5:Bool = True
#Else
    Const IS_HTML5:Bool = False
#End

#If TARGET="ios"
    Const IS_IOS:Bool = True
#Else
    Const IS_IOS:Bool = False
#End

#If TARGET="metro"
    Const IS_METRO:Bool = True
#Else
    Const IS_METRO:Bool = False
#End

#If TARGET="psm"
    Const IS_PSM:Bool = True
#Else
    Const IS_PSM:Bool = False
#End

#If TARGET="stdcpp"
    Const IS_STDCPP:Bool = True
#Else
    Const IS_STDCPP:Bool = False
#End

#If TARGET="xna"
    Const IS_XNA:Bool = True
#Else
    Const IS_XNA:Bool = False
#End

End
