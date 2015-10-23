#!/usr/bin/env python

import sys
import os.path

sasviewbase = os.environ.get('SRC_DIR', os.getcwd())

tdirmodules = [
        ('test/sasdataloader/test', [
                # 'error_conditions',
                # 'testLoad',
                # 'testplugings',
                'utest_abs_reader',
                'utest_ascii',
                'utest_averaging',
                'utest_cansas',
                'utest_red2d_reader',
                ]),
        ('test/sasmodels/test', [
                'utest_coreshellellipsoidXTmodel',
                'utest_disperser',
                'utest_dispersity',
                'utest_evaldist',
                'utest_extra_models',
                'utest_model_calculate_ER',
                'utest_model_onionexpshell',
                'utest_model_pearlnecklace',
                'utest_model_pringle',
                'utest_model_sphericalsldmodel',
                'utest_modelmultiplication',
                'utest_models',
                'utest_models_array',
                'utest_models_new1_3',
                'utest_newstylemodels',
                'utest_nonshape',
                'utest_other_dispersity',
                'utest_other_models',
                'utest_smearing',
                'utest_sphere_dispersity',
                'utest_state',
                ]),
        ('test/pr_inversion/test', [
                'utest_explorer',
                'utest_invertor',
                ])
]


def runsuite(tdir, modulenames):
    import unittest
    tdirfull = os.path.join(sasviewbase, tdir)
    os.chdir(tdirfull)
    sys.path.insert(0, tdirfull)
    suite = unittest.TestSuite()
    loader = unittest.defaultTestLoader
    for mname in modulenames:
        exec('import %s as mobj' % mname)
        suite.addTests(loader.loadTestsFromModule(mobj))
    runner = unittest.TextTestRunner()
    result = runner.run(suite)
    return result


def test():
    results = [runsuite(d, mods) for d, mods in tdirmodules]
    return results


if __name__ == '__main__':
    assert all(tr.wasSuccessful() for tr in test())
