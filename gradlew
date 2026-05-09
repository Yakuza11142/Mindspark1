#!/usr/bin/env sh
# Simplified Gradle Wrapper for Mobile Upload
if [ ! -d "gradle/wrapper" ]; then
    mkdir -p gradle/wrapper
fi
# This launches the wrapper jar
exec java -jar gradle/wrapper/gradle-wrapper.jar "$@"

