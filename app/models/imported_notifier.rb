class ImportedNotifier < ActionMailer::Base
  
   def gocrazy(recipient,username,password)
     recipients recipient.email_address_with_name
     from       "system@example.com"
     subject    "[SoDA] Website & Mailing List Migration: Username & Password (IMPORTANT)"
     body       "Your username is #{username} and your password is #{password}."
   end
end
