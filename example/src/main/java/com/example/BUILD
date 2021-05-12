load("@rules_java//java:defs.bzl", "java_binary")

java_library(
    name = "lombok_external_user_example",
    srcs = ["ProjectRunner.java", "Greeting.java"],
    deps = [
        "//example/src/main/java/com/example/cmdline:lombok_example"
    ]
)

java_binary(
    name = "runner",
    main_class = "com.example.ProjectRunner",
    runtime_deps = [":lombok_external_user_example"],
    visibility = ["//visibility:public"]
)
