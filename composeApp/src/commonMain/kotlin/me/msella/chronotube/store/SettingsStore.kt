package me.msella.chronotube.store

import com.russhwolf.settings.Settings

public object SettingsStore {

    const val KEY_API_KEY = "api_key"

    private val settings = Settings()

    fun getString(key: String, default: String = ""): String {
        return settings.getString(key, default)
    }

    fun setString(key: String, value: String) {
        settings.putString(key, value)
    }

}
