#!/bin/bash
# Shell Program to simulate a simple calculator

a=$1
op="$2"
b=$3

if [ $# -lt 3 ]
then
	echo "This scripts operates only with integer numbers"
	echo "$0 num1  opr num2"
	echo "opr can be +, -, / , x"
	exit 1
fi

case "$op" in
	+) echo $(( $a + $b ));;
	-) echo $(( $a - $b ));;
	/) echo $(( $a / $b ));;
	x) echo $(( $a * $b ));;
	*) echo "Error ";;
esac


