package me.msella.chronotube.screen

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.height
import androidx.compose.material3.Button
import androidx.compose.material3.Text
import androidx.compose.material3.TextField
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.getValue
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import cafe.adriel.voyager.core.screen.Screen
import cafe.adriel.voyager.navigator.LocalNavigator
import cafe.adriel.voyager.navigator.currentOrThrow
import kotlinx.coroutines.MainScope
import me.msella.chronotube.store.SettingsStore
import me.msella.chronotube.store.SettingsStore.KEY_API_KEY

class ApiKeyScreen : Screen {

    @Composable
    override fun Content() {
        val navigator = LocalNavigator.currentOrThrow
        Column(
            modifier = Modifier.fillMaxSize(),
            verticalArrangement = Arrangement.Center,
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            var apiKey by remember { mutableStateOf(SettingsStore.getString(KEY_API_KEY)) }
            LaunchedEffect(Unit) {
                if(apiKey.isNotEmpty()) {
                    navigator.replace(MainScreen())
                }
            }
            TextField(value = apiKey, onValueChange = { apiKey = it }, label = { Text("API key") })
            Spacer(Modifier.height(16.dp))
            Button(onClick = {
                SettingsStore.setString(KEY_API_KEY, apiKey)
                navigator.replace(MainScreen())
            }) {
                Text("Save")
            }
        }
    }

}