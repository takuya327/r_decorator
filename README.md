# DecoModel

A simple view helper for Rails 3. It's inspired by amatsuda/active_decorator and jcasimir/draper.

## Usage
    class Person < ActiveRecord::Base
      def say
         “Hey!”
      end
    end
    
    class PersonDecorator < DecoModel::Decorator
      def say
         origin.say * 3
      end
    end

    person = Person.new
    person.say # == “Hey!”
    person.decorate.say # “Hey!Hey!Hey!”
