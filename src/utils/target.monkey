Strict

#BONO_ANDROID_MARKET="google"
#If Not (BONO_ANDROID_MARKET="google") And Not (BONO_ANDROID_MARKET="amazon") And Not (BONO_ANDROID_MARKET="samsung")
    #Error "BONO: Invalid BONO_ANDROID_MARKET setting"
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

#If BONO_ANDROID_MARKET="samsung"
    Const IS_MARKET_SAMSUNG:Bool = True
#Else
    Const IS_MARKET_SAMSUNG:Bool = False
#End

#If LANG="js"
    Const LANG:String = "js"
#ElseIf LANG="as"
    Const LANG:String = "as"
#ElseIf LANG="java"
    Const LANG:String = "java"
#ElseIf LANG="cpp"
    Const LANG:String = "cpp"
#Else
    #Error "BONO: Unknown LANG in utils.Target"
#End

#If HOST="winnt"
    Const HOST:String = "winnt"
    Const IS_MAC:Bool = False
    Const IS_WIN:Bool = True
#ElseIf HOST="macos"
    Const HOST:String = "macos"
    Const IS_MAC:Bool = True
    Const IS_WIN:Bool = False
#Else
    #Error "BONO: Unknown HOST in utils.Target"
#End

#If CONFIG="debug"
    Const CONFIG:String = "debug"
    Const IS_DEBUG:Bool = True
    Const IS_RELEASE:Bool = False
#ElseIf CONFIG="release"
    Const CONFIG:String = "release"
    Const IS_DEBUG:Bool = False
    Const IS_RELEASE:Bool = True
#Else
    #Error "BONO: Unknown CONFIG in utils.Target"
#End

#If TARGET="android"
    Const TARGET:String = "android"
    Const IS_ANDROID:Bool = True
#Else
    Const IS_ANDROID:Bool = False
#End

#If TARGET="flash"
    Const TARGET:String = "flash"
    Const IS_FLASH:Bool = True
#Else
    Const IS_FLASH:Bool = False
#End

#If TARGET="glfw"
    Const TARGET:String = "glfw"
    Const IS_GLFW:Bool = True
#Else
    Const IS_GLFW:Bool = False
#End

#If TARGET="html5"
    Const TARGET:String = "html5"
    Const IS_HTML5:Bool = True
#Else
    Const IS_HTML5:Bool = False
#End

#If TARGET="ios"
    Const TARGET:String = "ios"
    Const IS_IOS:Bool = True
#Else
    Const IS_IOS:Bool = False
#End

#If TARGET="metro"
    Const TARGET:String = "metro"
    Const IS_METRO:Bool = True
#Else
    Const IS_METRO:Bool = False
#End

#If TARGET="psm"
    Const TARGET:String = "psm"
    Const IS_PSM:Bool = True
#Else
    Const IS_PSM:Bool = False
#End

#If TARGET="stdcpp"
    Const TARGET:String = "stdcpp"
    Const IS_STDCPP:Bool = True
#Else
    Const IS_STDCPP:Bool = False
#End

#If TARGET="xna"
    Const TARGET:String = "xna"
    Const IS_XNA:Bool = True
#Else
    Const IS_XNA:Bool = False
#End

End
