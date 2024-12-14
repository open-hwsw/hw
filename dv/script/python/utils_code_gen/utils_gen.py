import os

class utils:
    
    def __init__(self):
        self.utils_repositories_path = None
        self.utils_name = None
        self.utils_list = []

    def cfg_utils_repositories_path(self, path):
        if os.path.exists(path):
            self.utils_repositories_path = path

    def get_utils_repositories_path(self):
        return self.utils_repositories_path
    
    def get_utils_repositories_info(self):
        self.utils_list.clear()
        if(self.utils_repositories_path != None):
            for entries in os.listdir(self.utils_repositories_path):
                full_path = os.path.join(self.utils_repositories_path, entries)
                if os.path.isdir(full_path):
                    self.utils_list.append(entries)

    def cfg_utils_name(self, name):
        self.utils_name = name

    def create_utils(self):
        pass
    
    def add_utils(self):
        self.get_utils_repositories_info()
        if self.utils_name in self.utils_list:
            os.symlink(os.path.join(self.utils_repositories_path, self.utils_name), self.utils_name)

    def remove_utils(self):
        pass

utils_inst = utils()
#utils_inst.cfg_utils_repositories_path("..")
#utils_inst.get_utils_repositories_path()