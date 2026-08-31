package com.masteralanlab.avalon.service

import android.app.Service
import com.masteralanlab.avalon.common.BroadcastAction
import com.masteralanlab.avalon.common.GlobalState
import com.masteralanlab.avalon.common.sendBroadcast

interface ManagedService {
    fun start()

    fun stop()
}

internal fun Service.notifyVpnStartRequested() {
    GlobalState.log("VPN start requested")
    BroadcastAction.VPN_START_REQUESTED.sendBroadcast()
}

internal fun Service.notifyVpnRevoked() {
    GlobalState.log("VPN permission revoked")
    BroadcastAction.VPN_REVOKED.sendBroadcast()
}
