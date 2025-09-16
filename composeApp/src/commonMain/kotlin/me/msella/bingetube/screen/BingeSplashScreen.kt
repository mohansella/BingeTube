package me.msella.bingetube.screen

import androidx.compose.animation.core.FastOutSlowInEasing
import androidx.compose.animation.core.animateFloatAsState
import androidx.compose.animation.core.tween
import androidx.compose.foundation.layout.BoxWithConstraints
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.offset
import androidx.compose.foundation.layout.size
import androidx.compose.material3.LinearProgressIndicator
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.graphicsLayer
import androidx.compose.ui.layout.onGloballyPositioned
import androidx.compose.ui.unit.IntOffset
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
import kotlin.time.Duration
import kotlin.time.DurationUnit
import kotlin.time.TimeSource
import kotlin.time.toDuration

class BingeSplashScreen : Screen {

    val logger = Logger.withTag(BingeSplashScreen::class.simpleName!!)

    @Composable
    override fun Content() {
        val navigator = LocalNavigator.currentOrThrow
        BoxWithConstraints(
            modifier = Modifier.fillMaxSize(),
            contentAlignment = Alignment.Center
        ) {
            var lottieHeightPx by remember { mutableStateOf(0) }

            //animate transition from splash to lottie
            val scale by animateFloatAsState(
                targetValue = 1f,
                animationSpec = tween(durationMillis = 300, easing = FastOutSlowInEasing),
                label = "scale"
            )
            val alpha by animateFloatAsState(
                targetValue = 1f,
                animationSpec = tween(durationMillis = 200),
                label = "alpha"
            )

            val splashTargetSize = (minOf(maxWidth, maxHeight) * 0.6f)
            LottieStore.Image(
                LottieStore.Anim.BingePanda, modifier = Modifier.size(splashTargetSize)
                    .graphicsLayer(
                        scaleX = scale,
                        scaleY = scale,
                        alpha = alpha
                    ).onGloballyPositioned { coordinates ->
                        lottieHeightPx = coordinates.size.height
                    }
            )

            if (lottieHeightPx > 0) {
                LinearProgressIndicator(modifier = Modifier.align(Alignment.Center).offset {
                    IntOffset(x = 0, y = (lottieHeightPx / 2) + 32)
                })
            }
        }

        LaunchedEffect(Unit) {
            var screen: Screen
            val timeMark = TimeSource.Monotonic.markNow()
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
            val delta = 3.toDuration(DurationUnit.SECONDS) - timeMark.elapsedNow()
            if (delta > Duration.ZERO) {
                delay(delta)
            }
            navigator.replaceAll(screen)
        }
    }

}