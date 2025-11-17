#!/usr/bin/env sh
# Execute this file to run the Gradle wrapper
# (This is the standard Gradle wrapper shell script)
set -e
# Determine the project root
PRG="$0"
# Resolve links
while [ -h "$PRG" ]; do
  ls=`ls -ld "$PRG"`
  link=`expr "$ls" : '.*-> \(.*\)$'`
  if expr "$link" : '/.*' > /dev/null; then
    PRG="$link"
  else
    PRG=`dirname "$PRG"`"/$link"
  fi
done
SAVED="`pwd`"
cd "`dirname "$PRG"`"
SCRIPT_DIR="`pwd -P`"
cd "$SAVED"
if [ -z "$JAVA_HOME" ]; then
  echo "JAVA_HOME is not set - please set it to a Java 8+ JDK"
fi
exec java -jar "$SCRIPT_DIR/gradle/wrapper/gradle-wrapper.jar" "$@"
