PROJECT = webserver
DEPS = cowboy erlydtl erlang_ale jsx
dep_erlang_ale = git https://github.com/esl/erlang_ale master
dep_cowboy = git https://github.com/ninenines/cowboy 2.0.0-pre.3
dep_jsx = git https://github.com/talentdeficit/jsx 2.8.0
include erlang.mk
