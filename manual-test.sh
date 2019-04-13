#!/usr/bin/env bash

./scripts/ijcreate 'ij_test_foo' > /dev/null 2>&1
echo -e "TEST: Only 'ij_test_foo' should be listed"
./scripts/ijstatus | egrep "^>"

./scripts/ijcreate 'ij_test_bar' > /dev/null 2>&1
echo -e "\nTEST: Only 'ij_test_bar' should be listed"
./scripts/ijstatus | egrep "^>"

./scripts/ijump "ij_test_foo" > /dev/null 2>&1
echo -e "\nTEST: Only 'ij_test_foo' should be listed"
./scripts/ijstatus | egrep "^>"

./scripts/ijump-one 'libvcx' "ij_test_bar" > /dev/null 2>&1
echo -e "\nTEST: expect 'ij_test_foo' for 'libvcx' and 'libnullpay'"
echo -e "TEST: expect 'ij_test_bar' for 'libindy'"
./scripts/ijstatus | egrep "^>"

./scripts/ijrm-one 'libvcx' "ij_test_foo" > /dev/null 2>&1
echo -e "\nTEST: expect 'ij_test_foo' NOT to have 'libvcx' listed"
./scripts/ijstatus | egrep "^>"

echo -e "\nTEST: expect error saying 'ij_test_bar' can't be removed because it's being used"
./scripts/ijrm-one 'libvcx' "ij_test_bar"

./scripts/ijump "ij_test_bar" > /dev/null 2>&1
echo -e "\nTEST: Only 'ij_test_bar' should be listed"
./scripts/ijstatus | egrep "^>"

./scripts/ijrm "ij_test_foo" > /dev/null 2>&1
echo -e "\nTEST: 'ij_test_foo' SHOULD NOT be listed"
./scripts/ijstatus | egrep "ij_test"
