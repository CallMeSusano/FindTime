package com.kodeco.findtime.android

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.material3.TopAppBar
import androidx.compose.material3.TopAppBarDefaults
import androidx.compose.runtime.Composable
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.tooling.preview.Preview
import com.kodeco.findtime.android.ui.MainView
import io.github.aakira.napier.DebugAntilog
import io.github.aakira.napier.Napier


class MainActivity : ComponentActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // 1
        Napier.base(DebugAntilog())
        setContent {
            // 2
            MainView {
                // 3
                TopAppBar(
                    colors = TopAppBarDefaults.topAppBarColors(containerColor = MaterialTheme.colorScheme.primary),
                    title = {
                        // 4
                        when (it) {
                            0 -> Text(text = stringResource(R.string.world_time))
                            else -> Text(text = stringResource(R.string.findmeeting))
                        }
                    })
            }
        }
    }
}


//@Preview
@Composable
fun DefaultPreview() {
    MyApplicationTheme {
        Text("Hello, Android!")
    }
}