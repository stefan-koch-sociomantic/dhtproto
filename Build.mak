export ASSERT_ON_STOMPING_PREVENTION=1

override DFLAGS  += -w

ifeq ($(DVER),1)
override DFLAGS += -v2 -v2=-static-arr-params -v2=-volatile
else
override DFLAGS  += -de
DC:=dmd-transitional
endif

$B/fakedht: $C/src/fakedht/main.d
$B/fakedht: override LDFLAGS += -llzo2 -lebtree -lrt -lpcre

all += $B/fakedht

$O/%unittests: override LDFLAGS += -llzo2 -lebtree -lrt -lpcre

$O/test-fakedht: override LDFLAGS += -llzo2 -lebtree  -lrt -lpcre
$O/test-fakedht: $B/fakedht

$B/dhtapp: $C/src/dummydhtapp/main.d

$O/test-dhtrestart: $B/dhtapp
$O/test-dhtrestart: override LDFLAGS += -llzo2 -lebtree  -lrt -lpcre

$O/test-env: $B/dhtapp
$O/test-env: override LDFLAGS += -llzo2 -lebtree  -lrt -lpcre

run-test: $O/test-fakedht
	$O/test-fakedht
