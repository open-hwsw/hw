import os
import shutil

class utils:
    
    def __init__(self):
        self.utils_repositories_path = None
        self.utils_name = None
        self.utils_list = []
        self.utils_target_path = None

    def cfg_utils_repositories_path(self, path):
        if os.path.exists(path):
            self.utils_repositories_path = path
        else:
            return False

    def get_utils_repositories_path(self):
        return self.utils_repositories_path
    
    def get_utils_repositories_info(self):
        self.utils_list.clear()
        if(self.utils_repositories_path != None) and os.path.exists(self.utils_repositories_path):
            for entries in os.listdir(self.utils_repositories_path):
                if os.path.isdir(os.path.join(self.utils_repositories_path, entries)):
                    self.utils_list.append(entries)
            return True
        else:
            return False

    def cfg_utils_target_path(self, path):
        self.utils_target_path = path
        return True

    def get_utils_target_path(self):
        return self.utils_target_path

    def cfg_utils_name(self, name):
        self.utils_name = name
        return True

    def create_utils(self):
        if(self.utils_target_path != None) and (self.utils_name != None):
            os.mkdir(os.path.join(self.utils_target_path, self.utils_name))
            return True
        else:
            return False
    
    def clone_utils(self):
        if os.path.exists(os.path.join(self.utils_target_path, self.utils_name)) == False:
            if self.get_utils_repositories_info():
                if self.utils_name in self.utils_list:
                    os.symlink(os.path.join(self.utils_repositories_path, self.utils_name), os.path.join(self.utils_target_path, self.utils_name))
                    return True
                else:
                    return False
            else:
                return False
        else:
            return False

    def remove_utils(self):
        if os.path.exists(os.path.join(self.utils_target_path, self.utils_name)):
            if(os.path.islink(os.path.join(self.utils_target_path, self.utils_name))):
                os.unlink(os.path.join(self.utils_target_path, self.utils_name))
            else:
                shutil.rmtree(os.path.join(self.utils_target_path, self.utils_name))
            return True
        else:
            return False
        
    def push_utils(self):
        if os.path.exists(os.path.join(self.utils_target_path, self.utils_name)) and (os.path.exists(os.path.join(self.utils_repositories_path, self.utils_name)) == False):
            if os.path.isdir(os.path.join(self.utils_target_path, self.utils_name)):
                shutil.copytree(os.path.join(self.utils_target_path, self.utils_name), os.path.join(self.utils_repositories_path,self.utils_name))
                return True
            else:
                return False
        else:
            return False