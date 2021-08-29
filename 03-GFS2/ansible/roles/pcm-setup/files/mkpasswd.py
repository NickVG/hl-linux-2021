#!/usr/bin/python
import sys, crypt
if len(sys.argv) == 1 : sys.exit("You must supply the password!")
print(crypt.crypt(sys.argv[1], crypt.mksalt(crypt.METHOD_SHA512)))
