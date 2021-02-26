module SchemaHelper
  
  def to_choice(value)
    if value.nil?
      return nil
    end
    
    value ? 1 : 0
  end
  
  def qualities_select(selected = nil)
    options = {
      :include_blank => "Any quality",
      :selected => selected
    }
    html_options = {
      class: "form-control",
      name: "quality"
    }
    
    collection_select(:quality, :value, Quality.all, :value, :name, options, html_options)
  end
  
  def particles_select(selected = nil)
    options = {
      :include_blank => "Any effect",
      :selected => selected
    }
    html_options = {
      class: "form-control",
      name: "particle"
    }
    
    collection_select(:particle, :value, Particle.all.visible, :value, :name, options, html_options)
  end
  
  def item_name_autocomplete(item_name = nil, defindex = nil)
    item = Item.find_by_defindex(defindex) if defindex
    item_name = item.item_name if item
    
    text_field_tag(:item_name, item_name, placeholder: "Item", data: { :for => "items", :behavior => "autocomplete" }, class: "form-control")
  end
  
  def skin_name_autocomplete(skin_name = nil)
    text_field_tag(:skin_name, skin_name, placeholder: "Skin", data: { :for => "skins", :behavior => "autocomplete" }, class: "form-control")
  end
end