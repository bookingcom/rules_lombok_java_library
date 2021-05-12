load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_jar")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def lombok_java_library_dependencies():
    maybe(
        http_jar,
        name = "lombok_jar",
        url = "https://projectlombok.org/downloads/lombok-1.18.20.jar",
        sha256 = "ce947be6c2fbe759fbbe8ef3b42b6825f814c98c8853f1013f2d9630cedf74b0"
    )
