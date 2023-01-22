include Pagy::Frontend

module ApplicationHelper
  # def paginate(collection_or_options = nil, options = {})
  #   will_paginate collection_or_options, options.merge({ :renderer => RemoteLinkPaginationHelper::LinkRenderer, :class => 'pagination' })
  # end
  
  # def will_paginate(collection_or_options = nil, options = {})
  #   if collection_or_options.is_a? Hash
  #     options, collection_or_options = collection_or_options, nil
  #   end
    
  #   # unless options[:renderer]
  #   #   will_paginate collection, params.merge(:renderer => , :class => 'pagination')
  #   #   options = options.merge :renderer => RemoteLinkPaginationHelper::LinkRenderer
  #   # end
    
  #   # unless options[:class]
  #   #   options = options.merge :class => 'pagination'
  #   # end
    
  #   super(collection_or_options, options)
  # end
end
