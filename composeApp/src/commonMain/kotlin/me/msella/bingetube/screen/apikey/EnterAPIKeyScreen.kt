package me.msella.bingetube.screen.apikey

import androidx.compose.foundation.layout.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import cafe.adriel.voyager.core.screen.Screen
import cafe.adriel.voyager.navigator.LocalNavigator
import cafe.adriel.voyager.navigator.currentOrThrow
import co.touchlab.kermit.Logger
import me.msella.bingetube.store.LottieStore
import me.msella.bingetube.store.SettingsStore

data class EnterApiKeyScreen(val errorMessage: String = "") : Screen {

    val logger = Logger.withTag("EnterApiKeyScreen")

    @Composable
    override fun Content() {
        val navigator = LocalNavigator.currentOrThrow
        val snackBarHostState = remember { SnackbarHostState() }

        var apiKey by remember { mutableStateOf(SettingsStore.getString(SettingsStore.KEY_API_KEY)) }

        Box(modifier = Modifier.fillMaxSize()) {
            SnackbarHost(
                hostState = snackBarHostState,
                modifier = Modifier.align(Alignment.BottomCenter).padding(16.dp, 32.dp),
            ) { snackbarData ->
                Snackbar(
                    modifier = Modifier.fillMaxWidth(),
                    action = {
                        IconButton(
                            modifier = Modifier.align(Alignment.CenterEnd),
                            onClick = {
                                snackbarData.dismiss()
                            },
                        ) {
                            Text("X")
                        }
                    }
                ) {
                    Text(snackbarData.visuals.message)
                }
            }

            Column(
                modifier = Modifier.fillMaxSize(),
                verticalArrangement = Arrangement.Center,
                horizontalAlignment = Alignment.CenterHorizontally
            ) {
                if (errorMessage.isNotEmpty()) {
                    LaunchedEffect(Unit) {
                        logger.i("showing error message: $errorMessage")
                        snackBarHostState.showSnackbar(message = errorMessage, duration = SnackbarDuration.Indefinite)
                    }
                }
                LottieStore.Image(LottieStore.Anim.ApiKey)
                TextField(
                    value = apiKey,
                    onValueChange = { apiKey = it },
                    label = { Text("API key") },
                    singleLine = true,
                    modifier = Modifier.padding(horizontal = 16.dp),
                )
                Spacer(Modifier.height(16.dp))
                Button(enabled = apiKey.isNotEmpty(), onClick = {
                    logger.i("Save clicked. navigating to ValidateApiKeyScreen")
                    navigator.push(ValidateApiKeyScreen(apiKey))
                }) {
                    Text("Save")
                }
            }
        }
    }

}
