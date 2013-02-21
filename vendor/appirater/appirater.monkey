Private

#if TARGET="ios"

' ============================
' == COMMERCIAL BREAK START ==
' ============================
'
' Tired of setting things up? Monkey-Wizard to the rescue!
' --> https://github.com/michaelcontento/monkey-wizard
'
' And the whole thing should be easy as:
' --> wizard IosAppirater ../myproject/myproject.build/ios
'
' ============================
' ==  COMMERCIAL BREAK END  ==
' ============================

Import "native/appirater.ios.cpp"

Extern
Class Appirater="AppiraterMonk"
    Function Launched:Void()="AppiraterMonk::Launched"
End
#else
Public
Class Appirater
    Function Launched:Void()
        Print "Appirater: App launched"
    End
End
#end
