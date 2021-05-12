load("@rules_java//java:defs.bzl", "java_library")

DEFAULT_LOMBOK_JAR="@lombok_jar//jar"
DEFAULT_TOOLCHAIN="@bazel_tools//tools/jdk:current_java_runtime"

def lombok_java_library(name, srcs, lombok_jar=DEFAULT_LOMBOK_JAR, toolchain=DEFAULT_TOOLCHAIN):
    native.genrule(
        name = name,
        srcs = srcs,
        outs = [name + ".srcjar"],
        cmd = " && ".join([
            "TMP=$$(mktemp -d || mktemp -d -t bazel-tmp)",
            "$(JAVA) -jar $(location " + lombok_jar +") delombok $(SRCS) -d $$TMP",
            "$(JAVABASE)/bin/jar --create --file $(OUTS) $$TMP",
            "rm -rf $$TMP"
        ]),
        tools = [lombok_jar],
        toolchains = [toolchain],
        message = "Applying delombok to generate " + name
    )
