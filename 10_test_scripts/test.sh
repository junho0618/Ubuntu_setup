#!/bin/bash

echo 'juno_test_abcdefghijklmn' > /dev/ttyACM0
sleep 1

echo 'start_test_abcdefgh' > /dev/ttyACM0
sleep 1

echo 'juno_test_abcd' > /dev/ttyACM0
sleep 1
