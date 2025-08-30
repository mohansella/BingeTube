package me.msella.bingetube

import androidx.compose.material3.MaterialTheme
import androidx.compose.runtime.Composable
import cafe.adriel.voyager.core.screen.Screen
import cafe.adriel.voyager.navigator.Navigator
import co.touchlab.kermit.Logger
import me.msella.bingetube.screen.MainScreen
import me.msella.bingetube.screen.apikey.EnterApiKeyScreen
import me.msella.bingetube.store.SettingsStore
import me.msella.bingetube.store.SettingsStore.KEY_API_KEY
import org.jetbrains.compose.ui.tooling.preview.Preview


@Composable
@Preview
fun App() {
    val logger = Logger.withTag("App")

    logger.d("app starting")
    var apiKey = SettingsStore.getString(KEY_API_KEY, "")
    var screen : Screen
    if(apiKey.isEmpty()) {
        logger.i("api key empty. starting EnterApiKeyScreen")
        screen = EnterApiKeyScreen()
    } else {
        logger.i("api key set. starting MainScreen")
        screen = MainScreen()
    }
    MaterialTheme {
        Navigator(screen)
    }
}
