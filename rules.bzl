load("@rules_java//java:defs.bzl", "java_library")

DEFAULT_LOMBOK_JAR="@lombok_jar//jar"
DEFAULT_TOOLCHAIN="@bazel_tools//tools/jdk:current_java_runtime"

def lombok_java_library(name, srcs, classpath=[], lombok_jar=DEFAULT_LOMBOK_JAR, toolchain=DEFAULT_TOOLCHAIN, debug=False):
    line = "$(JAVA) -jar $(location " + lombok_jar +") delombok $(SRCS)"
    if classpath:
        classpath_cmd=":".join(["$(location " + x + ")" for x in classpath])
        line = line + " --classpath=" + classpath_cmd
    cmd = []
    if debug:
        cmd.extend(["pwd", "set -x"])
    cmd.extend([
        "TMP=$$(mktemp -d || mktemp -d -t bazel-tmp)",
        line + " -d $$TMP",
        "$(JAVABASE)/bin/jar --create --file $(OUTS) $$TMP",
        "rm -rf $$TMP"
    ])
    native.genrule(
        name = name,
        srcs = srcs,
        outs = [ name + ".srcjar" ],
        cmd = " && ".join(cmd),
        tools = [ lombok_jar ] + classpath,
        toolchains = [ toolchain ],
        message = "Applying delombok to generate " + name
    )
