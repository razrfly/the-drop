class Account < ActiveRecord::Base
  belongs_to :site
  belongs_to :user
  has_many :accounts

  def login
    agent = Mechanize.new { |a| a.user_agent_alias = 'Mac Safari' }

    # Get the login page
    page = agent.get(site.login_url)

    unless page.forms.blank? || page.uri.to_s =~ /password/
      form = page.form_with(action: site.login_url)
      form.field_with(name: "customer[email]").value = username
      form.field_with(name: "customer[password]").value = password
      fill_form = form.submit
      return agent
    else
      return nil
    end


  end
end
