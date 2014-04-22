class AlertMailer < ActionMailer::Base
  default from: "btrader@secondmarket.com"

def alert_email(alert,current_user)
    @alert = alert
    @user = current_user
    #change this url later
    @url  = 'http://localhost:3000/users/sign_in'
    mail(to: @user.email, subject: 'Alert Set')
    #mail(to: 'pks284@nyu.edu', subject: 'Arbitrage Opportunity!')
  end

def send_alert(alert)
    @alert = alert
    #change this url later
    @url  = 'http://localhost:3000/users/sign_in'
    mail(to: @alert.user.email, subject: 'Arbitrage Opportunity')
    #mail(to: 'pks284@nyu.edu', subject: 'Arbitrage Opportunity!')
end

end
