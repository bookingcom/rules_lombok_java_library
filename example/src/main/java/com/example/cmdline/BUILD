load("@rules_java//java:defs.bzl", "java_binary")
load("//:rules.bzl", "lombok_java_library")

lombok_java_library(
    name = "lombok_java_library",
    srcs = ["LombokExample.java"],
)

java_library(
    name = "lombok_example",
    srcs = [":lombok_java_library"] + ["Runner.java"],
    visibility = ["//visibility:public"]
)

java_binary(
    name = "runner",
    main_class = "com.example.cmdline.Runner",
    runtime_deps = [":lombok_example"],
)
