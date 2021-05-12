# Introduction

Bazel rule to run delombok over a set of lombok source files that can be used as source to a java_library even on
Bazel 4+

# Usage

In your workspace add this lines:

```
http_file needed HERE

load("@lombok_java_library//:deps.bzl", "lombok_java_library_dependencies")
lombok_java_library_dependencies()
```

In your build file you do something like:
```
load("@lombok_java_library//:rules.bzl", "lombok_java_library")

lombok_java_library(
    name = "lombok_java_library",
    srcs = ["LombokExample.java"],
)

java_library(
    name = "lombok_example",
    srcs = [":lombok_java_library"] + OTHER_SOURCES,
)
```
