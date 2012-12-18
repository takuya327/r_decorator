require 'spec_helper'

describe 'view_context on rspec' do
  let(:author) { Author.create(name: 'test') }
  subject { author.decorated }
  its(:name_link) { should be_html_safe }
end
