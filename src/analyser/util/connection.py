from subprocess import call

class Connection:
    def __init__(self, password, username="SYSTEM", instance=90, database="SystemDB"):
        self.username = username
        self.password = password
        self.instance = instance
        self.database = database

    def check(self):
        call(["hdbsql",
            "-i", str(self.instance),
            "-d", self.database,
            "-u", self.username,
            "-p", self.password,
            "-o", "/dev/null",
            "SELECT * from DUMMY"
        ])
