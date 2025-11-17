package com.startupdopatrick.projeto

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.material.Text
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Surface
import androidx.compose.runtime.Composable
import androidx.compose.ui.tooling.preview.Preview

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            AppContent()
        }
    }
}

@Composable
fun AppContent() {
    Surface(color = MaterialTheme.colors.background) {
        Text(text = "Bem-vindo(a) ao Projeto Android — Jetpack Compose")
    }
}

@Preview(showBackground = true)
@Composable
fun PreviewAppContent() {
    AppContent()
}
