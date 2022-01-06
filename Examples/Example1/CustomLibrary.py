'''
The TestObject class has the following public functions:

class TestObject:
    def authenticate(self, login: str, password: str) -> str: ...
    def get_user_id(self, token, login) -> str: ...
    def get_user_name(self, token, user_id) -> str: ...
    def get_user(self, token, user_id=None) -> Dict[str, str]: ...
    def get_user_all(self, token) -> List[Dict[str, str]]: ...
    def delete_user(self, token, userid): ...
    def get_logout(self, token): ...
    def put_user_password(self, token, new_password, user_id=None): ...
    def put_user_name(self, token, name, user_id=None): ...
    def put_user_right(self, token, right, user_id): ...
    def post_new_user(self, token, name, login) -> str: ...
'''

from TestObject import t
session = ""
ROBOT_LIBRARY_SCOPE = "SUITE"


def login_user(login, password):
    '''`Login User` authenticates a user to the backend.

    The session will be stored during this test suite.'''
    global session
    session = t.authenticate(login, password)


def get_all_users():
    '''`Get All Users` does return a list of user-dictionaries.

    A user dictionary has the keys `name`, `login`, `right` and `active`.
    This keyword need Admin privileges.

    Example:
    `{'name': 'Peter Parker', 'login': 'spider', 'right': 'user', 'active': True}`
    '''
    return t.get_user_all(session)


def create_new_user(name, login, password, right):
    '''Creates a new user with the give data.'''
    user_id = t.post_new_user(session, name, login)
    t.put_user_password(session, password, user_id)
    t.put_user_right(session, right, user_id)


def get_userdetails(user_id=None):
    '''Returs the own user data.'''
    return t.get_user(session, user_id)
