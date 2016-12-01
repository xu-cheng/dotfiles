import os
import subprocess

def SystemIncludePathasFlags(cpp=True):
    cc = "c++" if cpp else "cc"
    lang = "c++" if cpp else "c"
    cmd = "{} -E -x {} - -v </dev/null 2>&1".format(cc, lang)
    out = subprocess.check_output(cmd, shell=True).decode("utf-8")
    out = out.split("\n")
    out = out[out.index("#include <...> search starts here:") + 1:-1]
    out = out[0:out.index("End of search list.")]
    out = [p.strip() for p in out if not p.endswith("(framework directory)")]
    flags = [["-isystem", p] for p in out]
    return [f for ff in flags for f in ff]

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
        flags += [
                "-x",
                "c"
                ]

    flags += SystemIncludePathasFlags(cpp)
    return { "flags": flags, "do_cache": True }
