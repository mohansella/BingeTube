package me.msella.bingetube

import androidx.compose.material3.MaterialTheme
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import cafe.adriel.voyager.navigator.Navigator
import me.msella.bingetube.screen.BingeSplashScreen
import org.jetbrains.compose.ui.tooling.preview.Preview


@Composable
@Preview
fun App() {
    //below code can be called in android activity also during drawable splash screen
    LaunchedEffect(Unit) {
        AppCache.prepareForSplashScreen()
    }

    MaterialTheme {
        Navigator(BingeSplashScreen())
    }
}
