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
import kotlinx.coroutines.delay
import me.msella.bingetube.api.YoutubeAPI
import me.msella.bingetube.screen.SearchScreen
import me.msella.bingetube.store.LottieStore
import me.msella.bingetube.store.LottieStore.Anim
import me.msella.bingetube.store.SettingsStore
import kotlin.time.Duration
import kotlin.time.DurationUnit
import kotlin.time.TimeSource
import kotlin.time.toDuration

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
            LottieStore.Image(Anim.FlyingPaperPlane)
            Text("Validating key")
            Spacer(Modifier.height(8.dp))
            LinearProgressIndicator()
        }
        LaunchedEffect(Unit) {
            val timeMark = TimeSource.Monotonic.markNow()
            YoutubeAPI.validateApiKey(apiKey) { isSuccess, errorMessage ->
                if (navigator.lastItem == this@ValidateApiKeyScreen) {
                    if (isSuccess) {
                        val delta = 3.toDuration(DurationUnit.SECONDS) - timeMark.elapsedNow()
                        if (delta > Duration.ZERO) {
                            delay(delta)
                        }
                        logger.i("validate success. starting screen at MainScreen")
                        SettingsStore.setString(SettingsStore.KEY_API_KEY, apiKey)
                        navigator.replaceAll(SearchScreen())
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
