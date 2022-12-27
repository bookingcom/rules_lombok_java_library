load("@rules_java//java:defs.bzl", "java_library")

DEFAULT_LOMBOK_JAR = "@lombok_jar//jar"
DEFAULT_TOOLCHAIN = "@bazel_tools//tools/jdk:current_java_runtime"

def lombok_java_library(name, srcs, deps = [], lombok_jar = DEFAULT_LOMBOK_JAR, toolchain = DEFAULT_TOOLCHAIN, debug = False):
    line = "$(JAVA) -Dfile.encoding=UTF8 -jar $(execpath " + lombok_jar + ") delombok "
    files = dict()

    for src in srcs:
        path, file_name = src.rsplit("/", 1)
        if path not in files:
            files[path] = list()
        files[path].append(file_name)

    if deps:
        classpath_cmd = ":".join(["$(execpath " + x + ")" for x in deps])
        line = line + " --classpath=" + classpath_cmd

    cmd = []

    if debug:
        cmd.extend(["set -x", "echo $$PWD"])

    cmd.append("LOMBOK_OUT=delomboked")

    for path in files:
        files_in_dir = " ".join([("$(execpath " + path + "/" + x + ")") for x in files[path]])
        cmd.append(line + " " + files_in_dir + " -d " + "$$LOMBOK_OUT/" + path)

    cmd.append(
        "$(JAVABASE)/bin/jar --create --file $(OUTS) $$LOMBOK_OUT",
    )

    if lombok_jar not in deps:
        deps = [lombok_jar] + deps

    native.genrule(
        name = name,
        srcs = srcs,
        outs = [name + ".srcjar"],
        cmd = " && ".join(cmd),
        tools = deps,
        toolchains = [toolchain],
        message = "Applying delombok to generate " + name,
    )
