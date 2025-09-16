package me.msella.bingetube.screen

import androidx.compose.foundation.layout.BoxWithConstraints
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.size
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import cafe.adriel.voyager.core.screen.Screen
import cafe.adriel.voyager.navigator.LocalNavigator
import cafe.adriel.voyager.navigator.currentOrThrow
import co.touchlab.kermit.Logger
import kotlinx.coroutines.delay
import me.msella.bingetube.AppCache
import me.msella.bingetube.screen.apikey.EnterApiKeyScreen
import me.msella.bingetube.store.LottieStore
import me.msella.bingetube.store.SettingsStore
import me.msella.bingetube.store.SettingsStore.KEY_API_KEY
import kotlin.time.*

class BingeSplashScreen : Screen {

    val logger = Logger.withTag(BingeSplashScreen::class.simpleName!!)

    @Composable
    override fun Content() {
        val navigator = LocalNavigator.currentOrThrow
        BoxWithConstraints(
            modifier = Modifier.fillMaxSize(),
            contentAlignment = Alignment.Center
        ) {
            val splashTargetSize = (minOf(maxWidth, maxHeight) * 0.6f)
            LottieStore.Image(LottieStore.Anim.BingePanda, modifier = Modifier.size(splashTargetSize))
        }

        LaunchedEffect(Unit) {
            var screen: Screen
            val prepareTime = TimeSource.Monotonic.measureTime {
                AppCache.isReadyForSplashScreen.value = true
                logger.d("loading cache in binge splash screen")
                AppCache.prepareForAll()

                val apiKey = SettingsStore.getString(KEY_API_KEY, "")
                if (apiKey.isEmpty()) {
                    logger.i("api key empty. starting EnterApiKeyScreen")
                    screen = EnterApiKeyScreen()
                } else {
                    logger.i("api key set. starting MainScreen")
                    screen = SearchScreen()
                }
            }
            val loadingTime = 2.toDuration(DurationUnit.SECONDS)
            if (loadingTime - prepareTime > Duration.ZERO) {
                delay(loadingTime - prepareTime)
            }
            navigator.replaceAll(screen)
        }
    }

}