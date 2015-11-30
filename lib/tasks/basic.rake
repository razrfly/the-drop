# should kill all of these..
namespace :wave do

  desc "Get stuff"
  task :checkout => :environment do
    store_name = 'postersandtoys'
    collection_name = 'new-stuff'

    store = Shopify.find_by(name: store_name)

    begin
      # login
      account = store.accounts.first
      session = account.login

      unless session.blank?
        # search for posters
        store.get_products(collection_name).each do |product|
          if product.title.downcase =~ /halloween|brazil|dracula|conan|thx|leagues|topo|taxi|frankenstein|creature|nosferatu/
            puts "#{product.title} :: #{product.url}"

            # place product in cart
            store.add_to_cart(session,product.url)
          end
        end

        # checkout UNLESS cart loop blank
        my_account = store.checkout(session)
        pp my_account
        #puts my_account.uri.to_s
        Launchy.open(my_account.uri.to_s)

      else
        raise "closed"
      end

    rescue #Errno::ECONNREFUSED, SocketError, Net::ReadTimeout, Errno::ENETDOWN
      puts "Not yet #{Time.now}"
      sleep 0.3
      retry
    end
  end


end