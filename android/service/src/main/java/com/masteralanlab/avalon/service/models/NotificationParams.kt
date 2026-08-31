package com.masteralanlab.avalon.service.models

data class NotificationParams(
    val title: String = "Avalon",
    val stopText: String = "STOP",
    val onlyStatisticsProxy: Boolean = false,
)
