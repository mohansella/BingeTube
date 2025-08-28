package me.msella.chronotube.screen.apikey

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import cafe.adriel.voyager.core.screen.Screen
import cafe.adriel.voyager.navigator.LocalNavigator
import cafe.adriel.voyager.navigator.currentOrThrow
import co.touchlab.kermit.Logger
import kotlinx.coroutines.delay
import me.msella.chronotube.api.YoutubeAPI
import me.msella.chronotube.screen.MainScreen
import me.msella.chronotube.store.SettingsStore

data class ValidateApiKeyScreen(val apiKey: String) : Screen {
    val logger = Logger.withTag("ValidateApiKeyScreen")

    @Composable
    override fun Content() {
        val navigator = LocalNavigator.currentOrThrow
        Column(
            modifier = Modifier.fillMaxSize(),
            verticalArrangement = Arrangement.Center,
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            Text("Validating key")
        }
        LaunchedEffect(Unit) {
            YoutubeAPI.validateApiKey(apiKey) { isSuccess, errorMessage ->
                if (navigator.lastItem == this@ValidateApiKeyScreen) {
                    if (isSuccess) {
                        logger.i("validate success. starting screen at MainScreen")
                        SettingsStore.setString(SettingsStore.KEY_API_KEY, apiKey)
                        navigator.popAll()
                        navigator.replace(MainScreen())
                    } else {
                        logger.i("validating failed. navigation pop and replace")
                        navigator.pop()
                        navigator.replace(EnterApiKeyScreen("Unknown error. Invalid API Key"))
                    }
                }
            }
        }
    }
}