package me.msella.chronotube.screen

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material3.Button
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import cafe.adriel.voyager.core.screen.Screen
import cafe.adriel.voyager.navigator.LocalNavigator
import cafe.adriel.voyager.navigator.currentOrThrow
import co.touchlab.kermit.Logger
import me.msella.chronotube.screen.apikey.EnterApiKeyScreen
import me.msella.chronotube.store.SettingsStore
import me.msella.chronotube.store.SettingsStore.KEY_API_KEY

class MainScreen : Screen {

    val logger = Logger.withTag("MainScreen")

    @Composable
    override fun Content() {
        val navigator = LocalNavigator.currentOrThrow
        Column(
            modifier = Modifier.fillMaxSize(),
            verticalArrangement = Arrangement.Center,
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            Text("API Key: ${SettingsStore.getString(KEY_API_KEY)}")
            Button(
                onClick = {
                    logger.i("deleted api key. replacing navigation to EnterApiKeyScreen")
                    SettingsStore.setString(KEY_API_KEY, "")
                    navigator.popAll()
                    navigator.replace(EnterApiKeyScreen())
                },
            ) {
                Text("Delete key")
            }
        }
    }

}
