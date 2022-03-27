# -*- coding: utf-8 -*-
import os
import sys
import unittest
import pytest
import pymysql 

cur_dir = os.getcwd()
sys.path.append(f'{cur_dir}/../')

from app import app

# Setup of the place referred to in phpunit, teardown makes use of the fixture.
@pytest.fixture(scope="module")
def conn():
  conn = pymysql.connect(
    host="localhost",
    user="playuser",
    password="123456",
    db="playlist",
    charset="utf8",
    cursorclass=pymysql.cursors.DictCursor )

  yield conn
  conn.close()

@pytest.fixture
def cursor(conn):
  cursor = conn.cursor()
  yield cursor

@pytest.fixture
def initialize(cursor):
  print("Create Table")
  cursor.execute('CREATE TABLE test ( id int, name varchar(20))')
  
def test_created_table(cursor, initialize):
  cursor.execute("SELECT * FROM test")
  result = cursor.fetchall()
  assert len(result) == 0

@pytest.fixture
def delete_table(cursor):
  print("Delete Table")
  cursor.execute("DROP TABLE test")

def test_delete_table(cursor, delete_table):
  cursor.execute("SELECT table_name FROM information_schema.tables where table_name = 'test';")
  result = cursor.fetchall()
  assert len(result) == 0
