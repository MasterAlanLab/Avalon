package com.masteralanlab.avalon

import android.app.Application
import android.content.Context
import com.masteralanlab.avalon.common.GlobalState

class AvalonApplication : Application() {
    override fun attachBaseContext(base: Context?) {
        super.attachBaseContext(base)
        GlobalState.init(this)
    }
}
