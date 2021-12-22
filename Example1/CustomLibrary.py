from robot.libraries.BuiltIn import BuiltIn

b = BuiltIn()


class CustomLibrary:

    ROBOT_LISTENER_API_VERSION = 2
    ROBOT_LIBRARY_LISTENER: "CustomLibrary"
    ROBOT_LIBRARY_SCOPE = "GLOBAL"

    def __init__(self) -> None:
        b.log_to_console("l: Init")

    def start_suite(self, name, args):
        b.log_to_console(f"l start_suite: {name}")

    def start_test(self, name, args):
        b.log_to_console(f"l start_test: {name}")

    def start_keyword(self, name, args):
        b.log_to_console(f"l start_keyword: {name}")

    def end_keyword(self, name, args):
        b.log_to_console(f"l end_keyword: {name}")

    def end_test(self, name, args):
        b.log_to_console(f"l end_test: {name}")

    def end_suite(self, name, args):
        b.log_to_console(f"l end_suite: {name}")
