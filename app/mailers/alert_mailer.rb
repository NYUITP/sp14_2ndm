class AlertMailer < ActionMailer::Base
  default from: "pratik.shah@nyu.edu"

def alert_email(user)
    @user = user
    @url  = 'http://localhost:3000/users/sign_in'
    mail(to: @user.email, subject: 'Arbitrage Opportunity!')
  end

end
