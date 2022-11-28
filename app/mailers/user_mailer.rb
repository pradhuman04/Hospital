class UserMailer < ApplicationMailer
    def welcome_email
        mail(to: "pstpro0@gmail.com",from:"pradhuman04@gmail.com",subject:'Welcome to  Site',message:"hii!!")
      end
end
