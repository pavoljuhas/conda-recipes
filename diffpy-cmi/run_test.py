#!/usr/bin/env python

import unittest
import importlib

testmodulenames = '''
    diffpy.Structure.tests
    diffpy.utils.tests
    diffpy.srreal.tests
    pyobjcryst.tests
    diffpy.srfit.tests
'''.split()

testmodules = []
for mname in testmodulenames:
    tm = importlib.import_module(mname)
    testmodules.append(tm)

suite = unittest.TestSuite()
for tm in testmodules:
    suite.addTests(tm.testsuite())

runner = unittest.TextTestRunner()
result = runner.run(suite)

assert result.wasSuccessful()
