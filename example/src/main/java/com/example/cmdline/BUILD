load("@rules_java//java:defs.bzl", "java_binary")
load("//:rules.bzl", "lombok_java_library")

lombok_java_library(
    name = "lombok_java_library",
    srcs = ["LombokExample.java"],
    deps = [
        "@maven//:org_projectlombok_lombok",
        "@maven//:org_slf4j_slf4j_api"
    ],
    lombok_jar = "@maven//:org_projectlombok_lombok"
)

java_library(
    name = "lombok_example",
    srcs = [":lombok_java_library"],
    deps = [
        "@maven//:org_slf4j_slf4j_api"
    ],
    visibility = ["//visibility:public"],
)
