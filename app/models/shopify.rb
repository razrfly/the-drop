class Shopify < Site
  store_accessor :properties, :subdomain

  def login_url
    "https://#{subdomain}.myshopify.com/account/login"
  end

  def cart_url
    #"https://#{subdomain}.myshopify.com/cart"
    "http://#{url}/cart"
  end

  def get_products(collection='all')
    result = Feedjira::Feed.fetch_and_parse "http://#{url}/collections/#{collection}.atom"
    #return result.entries
    result.entries.each do |item|
      products.find_or_create_by(title: item.title, url: url, published_at: item.published)
    end
  end

  def add_to_cart(session, url)
    # change URL to some ID
    page = session.get(url)
    form = page.form_with(action: '/cart/add')
    # value here?
    fill_form = form.submit

    return session
  end

  def checkout(session)
    page = session.get(cart_url)
    form = page.form_with(action: '/cart')

    # output items in cart
    cart = form.fields_with(value: "1")
    puts "#{cart.size} item(s) in cart"

    # submit cart form ----> get redirect
    cart_form = session.submit(form, form.button_with(name: /checkout/))

    #######
    #payment_form = cart_form.forms[1]
    #payment_form.field_with(name: "checkout[credit_card][number]").value = '1111111111111111'
    ##payment_form.field_with(name: "checkout[credit_card][number]").value = '374716039282784'
    #payment_form.field_with(name: "checkout[credit_card][name]").value = 'Test Test'
    ##payment_form.field_with(name: "checkout[credit_card][name]").value = 'Holden Thomas'
    #payment_form.field_with(name: "checkout[credit_card][verification_value]").value = '6482'
    #payment_form.field_with(name: "checkout[credit_card][month]").value = '5'
    #payment_form.field_with(name: "checkout[credit_card][year]").value = '2018'
    #final = session.submit(payment_form, payment_form.buttons.first)

  end
end
