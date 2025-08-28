package me.msella.chronotube.screen.apikey

import androidx.compose.foundation.layout.*
import androidx.compose.material3.Button
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.material3.TextField
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import cafe.adriel.voyager.core.screen.Screen
import cafe.adriel.voyager.navigator.LocalNavigator
import cafe.adriel.voyager.navigator.currentOrThrow
import co.touchlab.kermit.Logger
import me.msella.chronotube.screen.MainScreen
import me.msella.chronotube.store.SettingsStore

data class EnterApiKeyScreen(val errorMessage: String = "") : Screen {

    val logger = Logger.withTag("EnterApiKeyScreen")

    @Composable
    override fun Content() {
        val navigator = LocalNavigator.currentOrThrow
        Column(
            modifier = Modifier.Companion.fillMaxSize(),
            verticalArrangement = Arrangement.Center,
            horizontalAlignment = Alignment.Companion.CenterHorizontally
        ) {
            var apiKey by remember { mutableStateOf(SettingsStore.getString(SettingsStore.KEY_API_KEY)) }
            if (errorMessage.isNotEmpty()) {
                LaunchedEffect(Unit) {
                    logger.i("showing error message: $errorMessage")
                }
                Text(
                    text = "Error: $errorMessage", color = MaterialTheme.colorScheme.error
                )
            }
            TextField(value = apiKey, onValueChange = { apiKey = it }, label = { Text("API key") })
            Spacer(Modifier.Companion.height(16.dp))
            Button(onClick = {
                logger.i("Save clicked. navigating to ValidateApiKeyScreen")
                navigator.push(ValidateApiKeyScreen(apiKey))
            }) {
                Text("Save")
            }
        }
    }

}