#!/usr/bin/env python

import sys
import unittest
import importlib

PY3K = sys.version_info[0] >= 3

testmodulenames = [
    ('diffpy.structure.tests' if PY3K else 'diffpy.Structure.tests'),
    'diffpy.utils.tests',
    'diffpy.srreal.tests',
    'pyobjcryst.tests',
    'diffpy.srfit.tests',
]

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
