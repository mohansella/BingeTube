package me.msella.chronotube.store

import co.touchlab.kermit.Logger
import com.russhwolf.settings.Settings

public object SettingsStore {
    val logger = Logger.withTag("SettingsStore")

    const val KEY_API_KEY = "api_key"

    private val settings = Settings()

    fun getString(key: String, default: String = ""): String {
        logger.i("SettingsStore.getString key:$key default:$default")
        return settings.getString(key, default)
    }

    fun setString(key: String, value: String) {
        logger.i("SettingsStore.setString key:$key default:$value")
        settings.putString(key, value)
    }

}
