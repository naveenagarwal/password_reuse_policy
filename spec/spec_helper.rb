$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

ENV['MONGOID_ENV'] = 'test'
ENV['RACK_ENV'] = 'test'

require 'pry'
require 'minitest/spec'
require 'minitest/autorun'
require 'password_reuse_policy'
