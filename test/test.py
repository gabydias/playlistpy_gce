# -*- coding: utf-8 -*-
import os
import unittest
import sys

cur_dir = os.getcwd()
sys.path.append(f'{cur_dir}/..')

from app import app

class Test(unittest.TestCase):

    def setUp(self):
        # cria uma instância do unittest, precisa do nome "setUp"
        self.app = app.test_client()

        # envia uma requisicao GET para a URL
        self.result = self.app.get('/playlist')

    def test_requisicao(self):
        # compara o status da requisicao (precisa ser igual a 200)
        self.assertEqual(self.result.status_code, 200)

if __name__ == '__main__':
    unittest.main()
