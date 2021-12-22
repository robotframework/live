import micropip
import js
import json
import os
import sys
import traceback

from importlib import import_module, reload


sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(""))))


try:
    from robot.libdoc import LibraryDocumentation
except ImportError:
    await micropip.install("robotframework")
    from robot.libdoc import LibraryDocumentation

try:

    def write_file(file_name, file_content):
        with open(file_name, "w") as f:
            f.writelines(file_content)

    file_catalog_dict = json.loads(file_catalog)
    for name, content in file_catalog_dict.items():
        file, ext = os.path.splitext(name)
        if ext in [".resource", ".py"]:
            write_file(name, content)
            if ext == ".py":
                m = import_module(file)
                m = reload(m)
            libdoc = LibraryDocumentation(name)
            js.postMessage(json.dumps({name: libdoc.to_dictionary()}))
    for lib in ['BuiltIn', 'String', 'Collections']:
        libdoc = LibraryDocumentation(lib)
        js.postMessage(json.dumps({lib: libdoc.to_dictionary()}))

except Exception as e:
    print("Exception:")
    traceback.print_exc()
    print(e)
