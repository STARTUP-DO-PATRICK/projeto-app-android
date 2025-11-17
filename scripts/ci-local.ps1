<#
  scripts/ci-local.ps1
  Executa localmente os passos principais do CI para este projeto:
   - verifica Java
   - gera o Gradle wrapper se possível
   - roda `./gradlew assembleDebug`, testes e lint
   - roda htmlhint em `index.html` se o npm estiver disponível

  Uso (PowerShell):
    .\scripts\ci-local.ps1
#>

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Write-Host "[ci-local] Iniciando verificação do ambiente..."

# Check Java
if (-not (Get-Command java -ErrorAction SilentlyContinue)) {
    Write-Error "Java não encontrado. Instale o JDK 11+ e garanta que 'java' esteja no PATH."
    exit 1
}

# Ensure Gradle wrapper exists or generate it if local gradle is available
if (-not (Test-Path './gradlew') -and -not (Test-Path './gradlew.bat')) {
    if (Get-Command gradle -ErrorAction SilentlyContinue) {
        Write-Host "[ci-local] Gradle instalado — gerando Gradle wrapper..."
        gradle wrapper --gradle-version 8.2.1
    } else {
        Write-Error "Nenhum 'gradlew' encontrado e Gradle não está instalado. Execute 'gradle wrapper --gradle-version 8.2.1' localmente ou instale Gradle."
        exit 1
    }
}

# Choose wrapper command for Windows PowerShell
$gradlewCmd = if (Test-Path './gradlew.bat') { '.\gradlew.bat' } else { '.\gradlew' }

Write-Host "[ci-local] Tornando o wrapper executável (se aplicável)..."
try { icacls .\gradlew /grant Everyone:RX | Out-Null } catch { }

Write-Host "[ci-local] Rodando assembleDebug..."
& $gradlewCmd assembleDebug --no-daemon

Write-Host "[ci-local] Rodando testes unitários (testDebugUnitTest)..."
& $gradlewCmd testDebugUnitTest --no-daemon

Write-Host "[ci-local] Rodando lint (lintDebug)..."
& $gradlewCmd lintDebug --no-daemon

# Optional HTML check
if (Get-Command npm -ErrorAction SilentlyContinue) {
    if (-not (Get-Command htmlhint -ErrorAction SilentlyContinue)) {
        Write-Host "[ci-local] htmlhint não encontrado - instalando globalmente via npm..."
        npm install -g htmlhint
    }
    Write-Host "[ci-local] Rodando htmlhint index.html"
    htmlhint index.html
} else {
    Write-Host "[ci-local] npm não encontrado — pulando checagem HTML (htmlhint)."
}

Write-Host "[ci-local] Concluído com sucesso."
exit 0
