class AuthorDecorator < RDecorator::Base

  def name_link
    link_to origin.name, author_path(origin), :id => origin.name
  end
  
  def reverse_name
    name.reverse
  end

  def capitalized_name
    name.capitalize
  end
  
end
