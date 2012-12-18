require 'spec_helper'

feature "Definition" do
  class Foo
    def say
      "Hey!"
    end
  end

  class FooDecorator < RDecorator::Base
    def say
      origin.say * 3
    end
  end
  
  class This
    def say
      "Yeah!"
    end
  end
  
  class ThatDecorator < RDecorator::Base
    decorate_for :this
    def say
      origin.say * 3
    end
  end

  scenario "Auto decoration by class-name" do
    foo = Foo.new
    foo.decorated.say.should eq "Hey!Hey!Hey!"
  end
  
  scenario "using 'decorate_for'" do
    this = This.new
    this.decorated.say.should eq "Yeah!Yeah!Yeah!"
  end
  
end
