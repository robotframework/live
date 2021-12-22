import micropip
import sys
import js
import json
import os
import traceback

from importlib import import_module, reload
from io import StringIO

sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(""))))


class Listener:

    ROBOT_LISTENER_API_VERSION = 2

    def _post_message(self):
        js.postMessage(json.dumps({"std_output": sys.stdout.getvalue()}))
        sys.__stdout__.truncate(0)

    def start_suite(self, name, args):
        self._post_message()

    def start_test(self, name, args):
        self._post_message()

    def start_keyword(self, name, args):
        self._post_message()

    def end_keyword(self, name, args):
        self._post_message()

    def end_test(self, name, args):
        self._post_message()

    def end_suite(self, name, args):
        self._post_message()


try:
    from robot import run, __version__
except ImportError:
    js.postMessage(json.dumps({"std_output": "Install Robot Framework Stack Trace\n"}))
    js.postMessage(json.dumps({"std_output": f"Install Robot Framework"}))
    await micropip.install("robotframework-stacktrace")
    from robot import run, __version__

    js.postMessage(json.dumps({"std_output": f" = version {__version__}\n"}))

try:

    def write_file(file_name, file_content):
        with open(file_name, "w") as f:
            f.writelines(file_content)

    file_catalog_dict = json.loads(file_catalog)

    for name, content in file_catalog_dict.items():
        write_file(name, content)

    try:
        js.postMessage(json.dumps({"std_output": "\n-- Running Robot Framework --\n"}))
        js.postMessage(
            json.dumps(
                {
                    "std_output": f"> robot --loglevel TRACE:INFO --exclude EXCL --skip SKIP\n"
                    f"  --removekeywords tag:REMOVE --flattenkeywords tag:FLAT test.robot\n"
                }
            )
        )
        org_stdout = sys.__stdout__
        org_stderr = sys.__stderr__
        sys.stdout = sys.__stdout__ = StringIO()
        sys.stderr = sys.__stderr__ = sys.__stdout__
        for name in file_catalog_dict:
            file_name, file_ext = os.path.splitext(name)
            if file_ext == ".py":
                m = import_module(file_name)
                m = reload(m)
        run(
            "test.robot",
            consolecolors="ansi",
            listener=["RobotStackTracer", Listener()],
            loglevel="TRACE:INFO",
            # include="INCL",
            exclude="EXCL",
            skip="SKIP",
            removekeywords="tag:REMOVE",
            flattenkeywords="tag:FLAT",
        )
    except Exception as e:
        traceback.print_exc(file=sys.__stdout__)
    finally:
        std_output = sys.__stdout__.getvalue()
        sys.__stdout__ = org_stdout
        sys.stdout = sys.__stdout__

    with open("log.html", "r") as f:
        html = str(f.read())
        js.postMessage(
            json.dumps({"html": html, "std_output": std_output, "finished": True})
        )

except Exception as e:
    print("Exception:")
    traceback.print_exc()
    print(e)
