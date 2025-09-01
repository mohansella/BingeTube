package me.msella.bingetube.screen.apikey

import androidx.compose.foundation.layout.*
import androidx.compose.material3.LinearProgressIndicator
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import cafe.adriel.voyager.core.screen.Screen
import cafe.adriel.voyager.navigator.LocalNavigator
import cafe.adriel.voyager.navigator.currentOrThrow
import co.touchlab.kermit.Logger
import me.msella.bingetube.api.YoutubeAPI
import me.msella.bingetube.compose.CompottieImage
import me.msella.bingetube.screen.MainScreen
import me.msella.bingetube.store.SettingsStore

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
            CompottieImage("files/lottie/loading-airplane.json")
            Text("Validating key")
            Spacer(Modifier.height(8.dp))
            LinearProgressIndicator()
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
                        navigator.replace(EnterApiKeyScreen(errorMessage))
                    }
                }
            }
        }
    }
}
