CPUS = $(shell nproc)
MODE = $(shell getconf LONG_BIT)
SVN_REV = $(shell svn info | grep 'Revision' | awk '{print $$2}')