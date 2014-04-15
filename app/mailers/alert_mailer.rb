class AlertMailer < ActionMailer::Base
  default from: "btrader@secondmarket.com"

def alert_email(alert)
    @alert = alert
    #change this url later
    @url  = 'http://localhost:3000/users/sign_in'
    #mail(to: current_user.email, subject: 'Arbitrage Opportunity!')
    mail(to: 'pks284@nyu.edu', subject: 'Arbitrage Opportunity!')
  end

end
