# RDecorator

A readable and simple view helper for Rails 3.

## Usage
    class Person < ActiveRecord::Base
      def say
         "Hey!"
      end
    end
    
    class PersonDecorator < RDecorator::Base
      def say
         origin.say * 3
      end
    end

    person = Person.new
    person.say # == "Hey!"
    person.decorated.say # == "Hey!Hey!Hey!"

## Notice
+ Most code of lib/rdecorator/view_context.rb and rspec files was copied from https://github.com/amatsuda/active_decorator.
  Copyright (c) 2011 Akira Matsuda under MIT-LICENSE.
  
+ lig/generators/* was copied from https://github.com/drapergem/draper under MIT-LICENSE.

