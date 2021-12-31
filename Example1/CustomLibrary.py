from robot.libraries.BuiltIn import BuiltIn
from TestObject import t, UserRight

b = BuiltIn()


class CustomLibrary:

    ROBOT_LIBRARY_SCOPE = "SUITE"

    def __init__(self) -> None:
        self.session = ""

    def login_user(self, login, password):
        self.session = t.authenticate(login, password)


    def get_all_users(self):
        return t.get_user_all(self.session)


    def create_new_user(
        self, name, login, password, right: UserRight
    ):
        user_id = t.post_new_user(self.session, name, login)
        t.put_user_password(self.session, password, user_id)
        t.put_user_right(self.session, right, user_id)


    def get_userdetails(self, user_id=None):
        return t.get_user(self.session, user_id)
