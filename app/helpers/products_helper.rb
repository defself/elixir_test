module ProductsHelper
  def price_with_sale(product)
    unless product.sale.zero?
      product.price *= 2
      css_class = "sale"
    end

    content_tag(:span, number_to_currency(product.price), class: css_class)
  end

  def modifier_link(product)
    if user = User.find_by(id: product.updated_by)
      link_to(user.full_name, "#")
    end
  end
end
