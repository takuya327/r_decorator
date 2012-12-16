# RDecorator

A simple view helper for Rails 3. It's inspired by amatsuda/active_decorator and jcasimir/draper.

## Usage
    class Person < ActiveRecord::Base
      def say
         “Hey!”
      end
    end
    
    class PersonDecorator < RDecorator::Base
      def say
         origin.say * 3
      end
    end

    person = Person.new
    person.say # == “Hey!”
    person.decorated.say # == “Hey!Hey!Hey!”
