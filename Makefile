PROJECT = webserver
DEPS = cowboy eunit_formatters erlydtl
dep_cowboy = git https://github.com/ninenines/cowboy master
include erlang.mk
