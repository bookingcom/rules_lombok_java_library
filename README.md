# Introduction

Bazel rule to run delombok over a set of lombok source files that can be used as source to a java_library even on
Bazel 4+

# Usage

In your workspace add this lines:

```
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

LOMBOK_RULES_VERSION = "0.0.2"
LOMBOK_RULES_SHA = "d28a6bb946be9780637df5b3e9acd12873ca8bbdceecd1f6d41859ac23a0c30b"
http_archive(
    name="rules_lombok_java_library",
    urls = ["https://github.com/bookingcom/rules_lombok_java_library/archive/refs/tags/v%s.tar.gz" % LOMBOK_RULES_VERSION],
    sha256 = LOMBOK_RULES_SHA,
    strip_prefix = "rules_lombok_java_library-%s" % LOMBOK_RULES_VERSION
)

# if you're not retrieving lombok from another source like jvm_rules_external maven repos
# then add the following two lines
# load("@rules_lombok_java_library//:deps.bzl", "lombok_java_library_dependencies")
# lombok_java_library_dependencies()
```

In your build file you do something like:
```
load("@rules_lombok_java_library//:rules.bzl", "lombok_java_library")

lombok_java_library(
    name = "lombok_java_library",
    srcs = ["LombokExample.java"],
    lombok_jar = "@maven//org_projectlombok_lombok",
    deps = [
        "@maven//org_projectlombok_lombok", # we're using lombok log support for instance
        "@maven//:org_slf4j_slf4j_api"
    ]
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
$ bazel run //example/src/main/java/com/example:runner
....
INFO: Build completed successfully, 1 total action
Hi!
[main] INFO com.example.cmdline.LombokExample - static builder
Test
```
