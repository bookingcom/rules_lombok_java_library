# Introduction

Bazel rule to run delombok over a set of lombok source files that can be used as source to a java_library even on
Bazel 4+

# Usage

In your workspace add this lines:

```
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name="rules_lombok_java_library",
    urls = ["https://github.com/bookingcom/rules_lombok_java_library/archive/refs/tags/0.0.1.tar.gz"],
    sha256 = "4e0b9fd4487bb0c8da3060bc6c8a43edb7dc3a8b62523ff641e4c2e0d1beaafb",
    strip_prefix = "rules_lombok_java_library-0.0.1"
)

load("@rules_lombok_java_library//:deps.bzl", "lombok_java_library_dependencies")
lombok_java_library_dependencies()
```

In your build file you do something like:
```
load("@rules_lombok_java_library//:rules.bzl", "lombok_java_library")

lombok_java_library(
    name = "lombok_java_library",
    srcs = ["LombokExample.java"],
)

java_library(
    name = "lombok_example",
    srcs = [":lombok_java_library"] + OTHER_SOURCES,
)
```

# Building and running the example

```
    $ git clone https://github.com/bookingcom/rules_lombok_java_library
    $ cd rules_lombok_java_library
    $ run //example/src/main/java/com/example:runner
    ....
    INFO: Build completed successfully, 1 total action
    Hi!
    Test
```
