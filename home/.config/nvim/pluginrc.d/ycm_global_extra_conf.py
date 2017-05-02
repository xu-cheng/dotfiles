import itertools
import os
import sys
import subprocess


def cc():
    if sys.platform == "darwin":
        llvm = "/usr/local/opt/llvm/bin/clang"
        if os.path.exists(llvm):
            return llvm
    return "cc"


def cxx():
    if sys.platform == "darwin":
        llvm = "/usr/local/opt/llvm/bin/clang++"
        if os.path.exists(llvm):
            return llvm
    return "c++"


def SystemIncludePathAsFlags(cpp=True):
    if cpp:
        compiler = cxx()
        lang = "c++"
    else:
        compiler = cc()
        lang = "c"

    args = [compiler, "-E", "-x", lang, "-", "-v"]
    out = subprocess.check_output(
        args,
        encoding="UTF-8",
        stdin=subprocess.DEVNULL,
        stderr=subprocess.STDOUT)
    out = out.split("\n")
    start = out.index("#include <...> search starts here:") + 1
    end = out.index("End of search list.")
    flags = [["-isystem", path.strip()] for path in out[start:end]
             if not path.endswith("(framework directory)")]
    return list(itertools.chain(*flags))


def FlagsForFile(filename, **kwargs):
    extension = os.path.splitext(filename)[1]
    cpp = extension != ".c"
    flags = [
        "-Wall",
        "-Wextra",
        "-Werror",
        "-Wno-long-long",
        "-Wno-variadic-macros",
        "-fexceptions",
        "-DNDEBUG",
    ]
    if cpp:
        flags += [
            "-std=c++14",
            "-x",
            "c++",
        ]
    else:
        flags += ["-x", "c"]

    flags += SystemIncludePathAsFlags(cpp)
    return {"flags": flags, "do_cache": True}
