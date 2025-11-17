@echo off
REM Execute this file to run the Gradle wrapper
setlocal
set PRG=%~dp0%~nx0
if "%JAVA_HOME%"=="" (
  echo JAVA_HOME is not set - please set it to a Java 8+ JDK
)
java -jar "%~dp0\gradle\wrapper\gradle-wrapper.jar" %*
endlocal
