Strict

Private

Import bono

Public

Class TargetTest Extends TestCase
    Method TestIsMarketGoogle:Void()
        #If TARGET="android"
            #If BONO_ANDROID_MARKET="google"
                AssertTrue(Target.IS_MARKET_GOOGLE)
                AssertFalse(Target.IS_MARKET_AMAZON)
            #Else
                AssertFalse(Target.IS_MARKET_GOOGLE)
            #End
        #Else
            AssertFalse(Target.IS_MARKET_GOOGLE)
            AssertFalse(Target.IS_MARKET_AMAZON)
        #End
    End

    Method TestIsMarketAmazon:Void()
        #If TARGET="android"
            #If BONO_ANDROID_MARKET="amazon"
                AssertFalse(Target.IS_MARKET_GOOGLE)
                AssertTrue(Target.IS_MARKET_AMAZON)
            #Else
                AssertFalse(Target.IS_MARKET_AMAZON)
            #End
        #Else
            AssertFalse(Target.IS_MARKET_GOOGLE)
            AssertFalse(Target.IS_MARKET_AMAZON)
        #End
    End

    Method TestPlatformId:Void()
        #If TARGET="android"
            AssertStringStartsWith("android:", Target.PLATFORM_ID)

            If Target.IS_MARKET_GOOGLE
                AssertStringEndsWith(":google", Target.PLATFORM_ID)
            ElseIf Target.IS_MARKET_AMAZON
                AssertStringEndsWith(":amazon", Target.PLATFORM_ID)
            Else
                MarkTestIncomplete("unknown android market")
            End
        #ElseIf TARGET="glfw" Or TARGET="stdcpp"
            AssertStringStartsWith(Target.HOST + ":", Target.PLATFORM_ID)
            AssertStringEndsWith(":" + Target.TARGET, Target.PLATFORM_ID)
        #Else
            AssertEquals(Target.TARGET, Target.PLATFORM_ID)
        #End
    End

    Method TestLang:Void()
        #If LANG="js"
            AssertEquals("js", Target.LANG)
        #ElseIf LANG="as"
            AssertEquals("as", Target.LANG)
        #ElseIf LANG="java"
            AssertEquals("java", Target.LANG)
        #ElseIf LANG="cpp"
            AssertEquals("cpp", Target.LANG)
        #End
    End

    Method TestHost:Void()
        #If HOST="winnt"
            AssertEquals("winnt", Target.HOST)
            AssertTrue(Target.IS_WIN)
            AssertFalse(Target.IS_MAC)
        #ElseIf HOST="macos"
            AssertEquals("macos", Target.HOST)
            AssertFalse(Target.IS_WIN)
            AssertTrue(Target.IS_MAC)
        #End
    End

    Method TestConfig:Void()
        #If CONFIG="debug"
            AssertEquals("debug", Target.CONFIG)
            AssertTrue(Target.IS_DEBUG)
            AssertFalse(Target.IS_RELEASE)
        #Else
            AssertEquals("release", Target.CONFIG)
            AssertFalse(Target.IS_DEBUG)
            AssertTrue(Target.IS_RELEASE)
        #End
    End

    Method TestAndroid:Void()
        #If TARGET="android"
            AssertEquals("android", Target.TARGET)
            AssertTrue(Target.IS_ANDROID)
        #Else
            AssertFalse(Target.IS_ANDROID)
        #End
    End

    Method TestFlash:Void()
        #If TARGET="flash"
            AssertEquals("flash", Target.TARGET)
            AssertTrue(Target.IS_FLASH)
        #Else
            AssertFalse(Target.IS_FLASH)
        #End
    End

    Method TestGLFW:Void()
        #If TARGET="glfw"
            AssertEquals("glfw", Target.TARGET)
            AssertTrue(Target.IS_GLFW)
        #Else
            AssertFalse(Target.IS_GLFW)
        #End
    End

    Method TestHTML5:Void()
        #If TARGET="html5"
            AssertEquals("html5", Target.TARGET)
            AssertTrue(Target.IS_HTML5)
        #Else
            AssertFalse(Target.IS_HTML5)
        #End
    End

    Method TestIos:Void()
        #If TARGET="ios"
            AssertEquals("ios", Target.TARGET)
            AssertTrue(Target.IS_IOS)
        #Else
            AssertFalse(Target.IS_IOS)
        #End
    End

    Method TestMetro:Void()
        #If TARGET="metro"
            AssertEquals("metro", Target.TARGET)
            AssertTrue(Target.IS_METRO)
        #Else
            AssertFalse(Target.IS_METRO)
        #End
    End

    Method TestPSM:Void()
        #If TARGET="psm"
            AssertEquals("psm", Target.TARGET)
            AssertTrue(Target.IS_PSM)
        #Else
            AssertFalse(Target.IS_PSM)
        #End
    End

    Method TestStdCpp:Void()
        #If TARGET="stdcpp"
            AssertEquals("stdcpp", Target.TARGET)
            AssertTrue(Target.IS_STDCPP)
        #Else
            AssertFalse(Target.IS_STDCPP)
        #End
    End

    Method TestXna:Void()
        #If TARGET="xna"
            AssertEquals("xna", Target.TARGET)
            AssertTrue(Target.IS_XNA)
        #Else
            AssertFalse(Target.IS_XNA)
        #End
    End
End
